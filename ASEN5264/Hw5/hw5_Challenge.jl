###########
# Question 3
###########

using CommonRLInterface
using Flux
using CommonRLInterface.Wrappers: QuickWrapper
using Plots
using DMUStudent.HW5: HW5, mc
# using VegaLite
# using ElectronDisplay # not needed if you're using a notebook or something that can display graphs
# using DataFrames: DataFrame


# Override to a discrete action space, and position and velocity observations rather than the matrix.
env = QuickWrapper(HW5.mc,
                   actions=[-1.0, -0.5, 0.0, 0.5, 1.0],
                   observe=mc->observe(mc)[1:2]
                  )

function dqn(env)
    # This network should work for the Q function - an input is a state; the output is a vector containing the Q-values for each action 
    Q = Chain(Dense(2, 128, relu),
            Dense(128, length(actions(env))))

    # Target network is a copy
    Q_target = deepcopy(Q)

    # Best Q function based on eval
    Q_best = deepcopy(Q)

    # Epsilon Greedy Policy
    function policy(s, epsilon=0.1)
        if rand() < epsilon
            return rand(1:length(actions(env)))
        else
            return argmax(Q(s))
            #return argmax(aInd->Q(s)[aInd], 1:length(actions(env)))
        end
    end

    # Gain experience function, appends the buffer
    function experience(buffer, n)
        # See if terminal
        done = terminated(env)
        i = 1
        # Loop through n steps in the environment and add to the buffer
        while i <= n && !done
            s = observe(env)
            a_ind = policy(s)
            r = act!(env, actions(env)[a_ind])
            sp = observe(env)
            done = terminated(env)
            experience_tuple = (s, a_ind, r, sp, done)
            push!(buffer, experience_tuple)                 # Add to the experience
            i = i + 1
        end
        return buffer
    end

    # Resets the buffer and gains experience
    function reset_buffer(n)
        # Reset buffer
        buffer = []
        i = 1
        # See if terminated
        done = terminated(env)
        # Loop through n steps in the environment and add to the buffer
        while i <= n && !done
            s = observe(env)
            a_ind = policy(s)
            r = act!(env, actions(env)[a_ind])
            sp = observe(env)
            done = terminated(env)
            experience_tuple = (s, a_ind, r, sp, done)
            push!(buffer, experience_tuple)                 # Add to the experience
            i = i + 1
        end
        return buffer
    end

    # Evaluate function for cummulative reward
    function eval(Q_eval, num_eps)
        totReward = 0
        for _ in 1:num_eps
            # Reset 
            reset!(env)
            j = 1
            while j <= 1000 && !terminated(env)
                s = observe(env)
                a_ind = argmax(Q_eval(s))
                r = act!(env, actions(env)[a_ind])
                totReward += r
                j += 1
            end
        end
        # Return the average reward per episode
        return totReward / num_eps
    end

    
    # Instantiate the buffer, 1000 steps for each episode
    n = 10000
    buffer = []
    buffer = experience(buffer, n)      # Initial buffer episode
    bestReward = -1000

    # Number of epochs
    epochs = 1000

    for epoch in 1:epochs
        # Rest the environment
        reset!(env)

        # Gain experience
        buffer = experience(buffer, n)


        # Q Training Loss Function
        function loss(Q, s, a_ind, r, sp, done)
            # Discount factor
            g = 0.99
            # Reached terminal state
            if done
                return (r - Q(s)[a_ind])^2
            end
            # DQN Loss Function
            return (r + g*maximum(Q_target(sp)) - Q(s)[a_ind])^2
        end

        # Get random data from the buffer
        data = rand(buffer, 1000)

        # Train based on random data in the buffer
        Flux.Optimise.train!(loss, Q, data, Flux.setup(ADAM(0.0005), Q))

        # Trash old buffer data
        if epoch % 20 == 0
            buffer = reset_buffer(n)
            
            # Set the target Q network
            Q_target = deepcopy(Q)
        end

        # Evaluate Epoch
        num_eps = 50
        avgReward = eval(Q, num_eps)
        if avgReward > bestReward           # Update if new best is found
            bestReward = avgReward
            Q_best = deepcopy(Q)
        end

        # Output data
        print("Epoch: ", epoch, "\t Buffer Size: ", length(buffer), "\t Average Reward: ", avgReward, "\n")
    end

    # Make sure to evaluate, print, and plot often! You will want to save your best policy.
    return Q_best
end

# Call DQN to get best Q function
Q = dqn(env)

# Evaluate
HW5.evaluate(s->actions(env)[argmax(Q(s[1:2]))], n_episodes=100) # you will need to remove the n_episodes=100 keyword argument to create a json file; evaluate needs to run 10_000 episodes to produce a json
#HW5.evaluate(s->actions(env)[argmax(Q(s[1:2]))], "thomas.dunnington@colorado.edu")

#----------
# Rendering
#----------

# You can show an image of the environment like this (use ElectronDisplay if running from REPL):
#display(render(env))

# The following code allows you to render the value function
xs = -3.0f0:0.1f0:3.0f0
vs = -0.3f0:0.01f0:0.3f0
h = heatmap(xs, vs, (x, v) -> maximum(Q([x, v])), xlabel="Position (x)", ylabel="Velocity (v)", title="Max Q Value")


# function render_value(value)
#     xs = -3.0:0.1:3.0
#     vs = -0.3:0.01:0.3
# 
#     data = DataFrame(
#                      x = vec([x for x in xs, v in vs]),
#                      v = vec([v for x in xs, v in vs]),
#                      val = vec([value([x, v]) for x in xs, v in vs])
#     )
# 
#     data |> @vlplot(:rect, "x:o", "v:o", color=:val, width="container", height="container")
# end
# 
# display(render_value(s->maximum(Q(s))))