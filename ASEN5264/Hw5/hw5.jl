using DMUStudent.HW5: HW5, mc
using QuickPOMDPs: QuickPOMDP
using POMDPTools: Deterministic, Uniform, SparseCat, FunctionPolicy, RolloutSimulator
using Statistics: mean
using Flux
import POMDPs
using Plots: scatter, scatter!, plot, plot!

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


σ = Flux.sigmoid
predict = Chain(Dense(1=>50,σ), Dense(50=>50,σ), Dense(50=>1))
#predict = Chain(Dense(1, 64, tanh), Dense(64, 1))
#loss(model, x, y) = mean(abs2.(model(x) .- y));
#loss(model, x, y) = mean(abs2.(model(x) .- y));
#loss(model, x, y) = sum((model(x)-y).^2)
loss(model, x, y) = Flux.mse(model(x), y);


opt = Descent(0.1)
data = [(x_train, y_train)]


# Train the model
lossVec = []
epochs = 1:250
for epoch in epochs
    train!(loss, predict, data, opt)
    push!(lossVec, loss(predict, x_train, y_train))
end

# Test model
x_test = hcat(rand(100)...) 
y_test = actual.(x_test)
y_model = predict(x_test)

# Plot the training data
trainPlot = scatter(vec(x_train), vec(y_train))

# Plot the learning curve
learningCurve = plot(epochs, lossVec, label="Learning Curve", xlabel="Epoch", ylabel="Mean Square Loss")

# Plot a set of 100 data points fed thrtough the trained model
finalP = scatter(vec(x_test), vec(y_model), label="Model Result")
scatter!(finalP, (vec(x_test)), (vec(y_test)), label="Actual Function", xlabel="Input", ylabel="Output")



############
# Question 3
############

# using CommonRLInterface
# using Flux
# using CommonRLInterface.Wrappers: QuickWrapper
# # using VegaLite
# # using ElectronDisplay # not needed if you're using a notebook or something that can display graphs
# # using DataFrames: DataFrame

# # The following are some basic components needed for DQN

# # Override to a discrete action space, and position and velocity observations rather than the matrix.
# env = QuickWrapper(HW5.mc,
#                    actions=[-1.0, -0.5, 0.0, 0.5, 1.0],
#                    observe=mc->observe(mc)[1:2]
#                   )

# function dqn(env)
#     # This network should work for the Q function - an input is a state; the output is a vector containing the Q-values for each action 
#     Q = Chain(Dense(2, 128, relu),
#               Dense(128, length(actions(env))))

#     # We can create 1 tuple of experience like this
#     s = observe(env)
#     a_ind = 1 # action index - the index, rather than the actual action itself, will be needed in the loss function
#     r = act!(env, actions(env)[a_ind])
#     sp = observe(env)
#     done = terminated(env)

#     experience_tuple = (s, a_ind, r, sp, done)

#     # this container should work well for the experience buffer:
#     buffer = [experience_tuple]
#     # you will need to push more experience into it and randomly select data for training

#     # create your loss function for Q training here
#     function loss(Q, s, a_ind, r, sp, done)
#         return (r-Q(s)[a_ind])^2 # this is not correct! you need to replace it with the true Q-learning loss function
#         # make sure to take care of cases when the problem has terminated correctly
#     end

#     # select some data from the buffer
#     data = rand(buffer, 10)

#     # do your training like this (you may have to adjust some things, and you will have to do this many times):
#     Flux.Optimise.train!(loss, Q, data, Flux.setup(ADAM(0.0005), Q))

#     # Make sure to evaluate, print, and plot often! You will want to save your best policy.
    
#     return Q
# end

# Q = dqn(env)

# HW5.evaluate(s->actions(env)[argmax(Q(s[1:2]))], n_episodes=100) # you will need to remove the n_episodes=100 keyword argument to create a json file; evaluate needs to run 10_000 episodes to produce a json

# #----------
# # Rendering
# #----------

# # You can show an image of the environment like this (use ElectronDisplay if running from REPL):
# display(render(env))

# # The following code allows you to render the value function
# using Plots
# xs = -3.0f0:0.1f0:3.0f0
# vs = -0.3f0:0.01f0:0.3f0
# heatmap(xs, vs, (x, v) -> maximum(Q([x, v])), xlabel="Position (x)", ylabel="Velocity (v)", title="Max Q Value")


# # function render_value(value)
# #     xs = -3.0:0.1:3.0
# #     vs = -0.3:0.01:0.3
# # 
# #     data = DataFrame(
# #                      x = vec([x for x in xs, v in vs]),
# #                      v = vec([v for x in xs, v in vs]),
# #                      val = vec([value([x, v]) for x in xs, v in vs])
# #     )
# # 
# #     data |> @vlplot(:rect, "x:o", "v:o", color=:val, width="container", height="container")
# # end
# # 
# # display(render_value(s->maximum(Q(s))))