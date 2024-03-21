using DMUStudent.HW5: HW5, mc
using QuickPOMDPs: QuickPOMDP
using POMDPTools: Deterministic, Uniform, SparseCat, FunctionPolicy, RolloutSimulator
using Statistics: mean
using Flux
import POMDPs
using Plots: scatter, scatter!, plot, plot!
using CommonRLInterface
using CommonRLInterface.Wrappers: QuickWrapper
using DMUStudent.HW5: HW5, mc

##############
# Instructions
##############
#=

This starter code is here to show examples of how to use the HW5 code that you
can copy and paste into your homework code if you wish. It is not meant to be a
fill-in-the blank skeleton code, so the structure of your final submission may
differ from this considerably.

=#

############
# Question 1
############

cancer = QuickPOMDP(
    states = [:healthy, :inSitu, :invasive, :death],
    actions = [:wait, :test, :treat],
    observations = [:positive, :negative],

    # transition should be a function that takes in s and a and returns the distribution of s'
    transition = function (s, a)
        if s == :healthy
            return SparseCat([:healthy, :inSitu], [0.98, 0.02])
        elseif s == :inSitu
            if a == :treat
                return SparseCat([:healthy, :inSitu], [0.6, 0.4])
            else    
                return SparseCat([:invasive, :inSitu], [0.1, 0.9])
            end
        elseif s == :invasive
            if a == :treat
                return SparseCat([:healthy, :death, :invasive], [0.2, 0.2, 0.6])
            else
                return SparseCat([:death, :invasive], [0.6, 0.4])
            end
        else    # Dead
            return Deterministic(s)
        end
    end,

    # observation should be a function that takes in s, a, and sp, and returns the distribution of o
    observation = function (s, a, sp)
        if a == :test
            if sp == :healthy
                return SparseCat([:positive, :negative], [0.05, 0.95])
            elseif sp == :inSitu
                return SparseCat([:positive, :negative], [0.80, 0.20])
            elseif sp == :invasive
                return Deterministic(:positive)
            else
                return Deterministic(:negative)
            end
        elseif a == :treat
            if sp == :inSitu || sp == :invasive
                return Deterministic(:positive)
            else
                return Deterministic(:negative)
            end
        else
            return Deterministic(:negative)
        end
    end,

    reward = function (s, a)
        if s == :death
            return 0
        else
            if a == :wait
                return 1
            elseif a == :test
                return 0.8
            else    # treat
                return 0.1                    
            end
        end
    end,

    initialstate = Deterministic(:healthy),

    discount = 0.99
)



# evaluate with a policy that always waits
policy = FunctionPolicy(o->:wait)
sim = RolloutSimulator(max_steps=100)
@show @time mean(POMDPs.simulate(sim, cancer, policy) for _ in 1:10_000)




############
# Question 2
############
using Flux: train!

# The notebook at https://github.com/zsunberg/CU-DMU-Materials/blob/master/notebooks/110-Neural-Networks.ipynb can serve as a starting point for this problem.
actual(x) = (1-x)*sin(20*log(x+0.2))

nTrain = 1000
x_train = hcat(rand(nTrain)...)             # 1000 data points from 0 to 1
y_train = actual.(x_train)              # Actual function data


predict = Chain(Dense(1=>50,leakyrelu), Dense(50=>50,leakyrelu), Dense(50=>50,leakyrelu), Dense(50=>50,leakyrelu), Dense(50=>50,leakyrelu), Dense(50=>1))
#predict = Chain(Dense(1, 64, tanh), Dense(64, 1))
#loss(model, x, y) = mean(abs2.(model(x) .- y));
#loss(model, x, y) = mean(abs2.(model(x) .- y));
#loss(model, x, y) = sum((model(x)-y).^2)
loss(model, x, y) = Flux.mse(model(x), y);


# Optimizer setup
opt = Flux.setup(Adam(), predict)

# Combine Data
data = [(x_train, y_train)]

# Train the model
lossVec = []
epochs = 1:2000
for epoch in epochs
    train!(loss, predict, data, opt)
    push!(lossVec, loss(predict, x_train, y_train))
end

# Test model
x_test = hcat(0:0.01:1...) 
y_test = actual.(x_test)
y_model = predict(x_test)

# Plot the training data
trainPlot = scatter(vec(x_train), vec(y_train))

# Plot the learning curve
learningCurve = plot(epochs, lossVec, label="Learning Curve", xlabel="Epoch", ylabel="Mean Square Loss")

# Plot a set of 100 data points fed thrtough the trained model
finalP = scatter(vec(x_test), vec(y_model), label="Model Result")
plot!(finalP, (vec(x_test)), (vec(y_test)), label="Actual Function", xlabel="Input", ylabel="Output")



############
# Question 3
############


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

    # Average reward vector and loss vector
    epochReward = []
    lossVec = []

    # HYPERPARAMETERS
    # Size of the buffer
    bufferSize = 50000
    e_orig = 0.1
    epsilon = 0.1
    n = 10000
    epochs = 1000

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
    function experience(buffer, n, epsilon)
        # See if terminal
        done = terminated(env)
        i = 1
        # Recently added buffer
        recentBuffer = []
        # Loop through n steps in the environment and add to the buffer
        while i <= n && !done
            s = observe(env)
            a_ind = policy(s)
            r = act!(env, actions(env)[a_ind])
            sp = observe(env)
            done = terminated(env)
            experience_tuple = (s, a_ind, r, sp, done)
            push!(buffer, experience_tuple)                 # Add to the experience
            push!(recentBuffer, experience_tuple)                 # Add to the experience
            i = i + 1
        end
        return buffer, recentBuffer
    end

    # Resets the buffer and gains experience
    function reset_buffer(n, epsilon)
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
    buffer = []
    buffer, recentBuffer = experience(buffer, n, e_orig)      # Initial buffer episode
    bestReward = -1000

    for epoch in 1:epochs
        # Rest the environment
        reset!(env)

        # Set Optimizer
        opt = Flux.setup(ADAM(0.0005), Q)

        # Decay epsilon, goes to 0 in half of the epochs
        # epsilon = e_orig * (1 - epoch/(epochs/2))
        epsilon = epsilon * 0.99


        # Gain experience
        buffer, recentBuffer = experience(buffer, n, epsilon)

        # Reset the target network
        # if epoch % 10 == 0
        #     # Set the target Q network
        #     Q_target = deepcopy(Q)
        # end

        Q_target = deepcopy(Q)
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
        data = rand(buffer, 2000)

        # Train based on random data in the buffer
        Flux.Optimise.train!(loss, Q, data, opt)

        # Evaluate Epoch, Update if new best is found
        num_eps = 500
        #avgReward = eval(Q, num_eps)
        score = HW5.evaluate(s->actions(env)[argmax(Q(s[1:2]))], n_episodes=num_eps)
        avgReward = score[1]
        push!(epochReward, avgReward)
        if avgReward > bestReward           
            bestReward = avgReward
            Q_best = deepcopy(Q)
            buffer = recentBuffer           # Reset the buffer with the good buffer data
        end

        # Shift the buffer if exceeding buffer size
        if length(buffer) > bufferSize
            buffer = buffer[end-bufferSize:end]
        end

        # Calculate the loss
        push!(lossVec, mean([loss(Q, s, a_ind, r, sp, done) for (s, a_ind, r, sp, done) in data]))

        # Output data
        print("Epoch: ", epoch, "\t Buffer Size: ", length(buffer), "\t Average Reward: ", avgReward, "\n")
    end

    # Make sure to evaluate, print, and plot often! You will want to save your best policy.
    return Q_best, epochReward, lossVec
end

# Call DQN to get best Q function
Q, epochReward, lossVec = dqn(env)


# Evaluate
HW5.evaluate(s->actions(env)[argmax(Q(s[1:2]))], n_episodes=100) # you will need to remove the n_episodes=100 keyword argument to create a json file; evaluate needs to run 10_000 episodes to produce a json
#HW5.evaluate(s->actions(env)[argmax(Q(s[1:2]))], "thomas.dunnington@colorado.edu")

# Plot the learning curve for the average reward
rewardPlot = plot(1:length(epochReward), epochReward, label="Average Reward", xlabel="Epoch", ylabel="Average Reward", title="Learning Curve Rewards")
hline!(rewardPlot, [40], line=:dash, label="Reward of 40")

lossPlot = plot(1:length(lossVec), lossVec, label="Loss", xlabel="Epoch", ylabel="DQN Loss", title="Learning Curve Loss")

#----------
# Rendering
#----------

# You can show an image of the environment like this (use ElectronDisplay if running from REPL):
#display(render(env))

# The following code allows you to render the value function
xs = -3.0f0:0.1f0:3.0f0
vs = -0.3f0:0.01f0:0.3f0
h = heatmap(xs, vs, (x, v) -> maximum(Q([x, v])), xlabel="Position (x)", ylabel="Velocity (v)", title="Max Q Value")