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


# The following are some basic components needed for DQN

# Override to a discrete action space, and position and velocity observations rather than the matrix.
env = QuickWrapper(HW5.mc,
                   actions=[-1.0, -0.5, 0.0, 0.5, 1.0],
                   observe=mc->observe(mc)[1:2]
                  )

function dqn(env)
    # This network should work for the Q function - an input is a state; the output is a vector containing the Q-values for each action 
    Q = Chain(Dense(2, 128, relu),
              Dense(128, length(actions(env))))

    # Epsilon Greedy Policy
    function policy(s)
        epsilon = 0.1
        if rand() < epsilon
            return rand(1:length(actions(env)))
        else
            return argmax(aInd->Q(s)[aInd], 1:length(actions(env)))
        end
    end

    # Gain experience function
    function experience(n)
        # Get experience
        s = observe(env)
        a_ind = 1 
        r = act!(env, actions(env)[a_ind])
        sp = observe(env)
        done = terminated(env)
        experience_tuple = (s, a_ind, r, sp, done)

        # Buffer container of experience tuples
        buffer = [experience_tuple]

        for _ in 1:n
            s = observe(env)
            a_ind = policy(s)
            r = act!(env, actions(env)[a_ind])
            sp = observe(env)
            done = terminated(env)
            experience_tuple = (s, a_ind, r, sp, done)
            push!(buffer, experience_tuple)                 # Add to the experience
        end
        return buffer
    end

    # create your loss function for Q training here
    function loss(Q, s, a_ind, r, sp, done)
        # Discount factor
        g = 0.99

        # Return 0 if terminal
        if done
            return 0
        end

        # DQN Loss Function
        return (r + g*maximum(Q(sp)[tempInd] for tempInd in 1:length(actions(env))) - Q(s)[a_ind])^2
        #return (r-Q(s)[a_ind])^2 # this is not correct! you need to replace it with the true Q-learning loss function
        # make sure to take care of cases when the problem has terminated correctly
    end

    # Number of epochs
    epochs = 100

    for i in 1:epochs
        # Gain experience
        buffer = experience(100)

        # select some data from the buffer
        data = rand(buffer, 10)

        # do your training like this (you may have to adjust some things, and you will have to do this many times):
        Flux.Optimise.train!(loss, Q, data, Flux.setup(ADAM(0.0005), Q))
    end

    # Make sure to evaluate, print, and plot often! You will want to save your best policy.
    return Q
end


# Get value function
Q = dqn(env)

# Evaluate
HW5.evaluate(s->actions(env)[argmax(Q(s[1:2]))], n_episodes=100) # you will need to remove the n_episodes=100 keyword argument to create a json file; evaluate needs to run 10_000 episodes to produce a json

#----------
# Rendering
#----------

# You can show an image of the environment like this (use ElectronDisplay if running from REPL):
#display(render(env))

# The following code allows you to render the value function
xs = -3.0f0:0.1f0:3.0f0
vs = -0.3f0:0.01f0:0.3f0
heatmap(xs, vs, (x, v) -> maximum(Q([x, v])), xlabel="Position (x)", ylabel="Velocity (v)", title="Max Q Value")


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