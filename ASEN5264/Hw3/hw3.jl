using DMUStudent.HW3: HW3, DenseGridWorld, visualize_tree
using POMDPs: actions, @gen, isterminal, discount, statetype, actiontype, simulate, states, initialstate, support
#using POMDPs
using D3Trees: inchrome, inbrowser
using StaticArrays: SA
using Statistics: mean, std
using BenchmarkTools: @btime

##############
# Instructions
##############
#=

This starter code is here to show examples of how to use the HW3 code that you
can copy and paste into your homework code if you wish. It is not meant to be a
fill-in-the blank skeleton code, so the structure of your final submission may
differ from this considerably.

Please make sure to update DMUStudent to gain access to the HW3 module.

=#

############
# Question 2
############

m = HW3.DenseGridWorld(seed = 3)


function rollout(mdp, policy, s0, max_steps=100)
    # This function computes the reward returned from a stochastic rollout using a heuristic policy
    r_total = 0.0
    t = 0
    s = s0
    while !isterminal(mdp, s) && t < max_steps
        a = policy(mdp, s)                      # Use the heuristic policy to get the next action
        s, r = @gen(:sp, :r)(mdp, s, a)         # Use generative model to get the next state and reward
        r_total += discount(m)^t * r            # Accumulated discounted reward
        t += 1                                  # Update time step
    end

    return r_total  # Return the reward
end


function random_policy(m, s)
    # Random Policy
    return rand(actions(m))
end


# function heuristic_policy(m, s)
#     # Choose the action that has the highest reward from the given state
#     rMax = -1000
#     aMax = actions(m)[1]

#     for a in actions(m)
#         sp, r = @gen(:sp, :r)(m, s, a)         # Use generative model to get the next state and reward
#         if r > rMax
#             rMax = r
#             aMax = a
#         end
#     end

#     return aMax
# end

# Reward states at [40,40] [20,40] [40,20] [20,20]
function heuristic_policy(m, s)
    if s[2] % 20 != 0           # Align y position
        if s[2] - 40 > 0
            return :down
        else
            return :up
        end
    elseif s[1] % 20 != 0       # Align x position
        if s[1] - 40 > 0
            return :left
        else
            return :right
        end
    else                        # Should have reached terminal state, doesn't matter whats returned here
        return rand(actions(m))
    end
end


# Run Monte Carlo using the random policy
simNum = 1000
results = [rollout(m, random_policy, rand(initialstate(m))) for _ in 1:simNum]

# Calculate the mean and standard deviation
meanReward = mean(results)
stdReward = std(results)

# Standard error of the mean
SEM = stdReward / sqrt(length(results))

# Print results
print("Random Policy:\n")
print("Mean: ", meanReward, "\n")
print("SEM: ", SEM, "\n\n")


# Improved Heuristic Policy
results = [rollout(m, heuristic_policy, rand(initialstate(m))) for _ in 1:simNum]

# Calculate the mean and standard deviation
meanReward = mean(results)
stdReward = std(results)

# Standard error of the mean
SEM = stdReward / sqrt(length(results))

# Print results
print("Heuristic Policy:\n")
print("Mean: ", meanReward, "\n")
print("SEM: ", SEM, "\n\n")


############
# Question 3
############
# Perform 7 iterations of Monte Carlo Tree Search, start at (19.19)

m = DenseGridWorld(seed = 4)

S = statetype(m)
A = actiontype(m)


# Bonus macro
bonus(Nsa, Ns) = Nsa == 0 ? Inf : sqrt(log(Ns)/Nsa) 

# Explore function
function explore(s, m, c, N, Q)
    A = actions(m)
    Ns = sum(N[(s, a)] for a in A)                  # Total visit count

    aVals = []                                      # Loop through actions at current state 
    for a in A
        push!(aVals, Q[(s,a)] + c*bonus(N[(s,a)], Ns))
    end

    return A[argmax(aVals)]                         # Return the most favorable action
end


# Simulate function
function simulate!(s, d, m, N, Q, T)
    if d <= 0                                       # Base case
        return rollout(m, heuristic_policy, s)      # Rollout with heuristic policy
    end

    # if isterminal(m, s)                                # Reached terminal, return reward
    #     return 100
    # end

    A = actions(m)
    g = discount(m)
    c = 100                                         # Exploration parameter

    if !haskey(N, (s, A[1]))                        # Add state and action to the dictionary
        for a in A
            N[(s,a)] = 0                            # Initialize to zero
            Q[(s,a)] = 0.0                  
        end
        return rollout(m, heuristic_policy, s)
    end

    a = explore(s, m, c, N, Q)                      # Get best action
    sp, r = @gen(:sp, :r)(m, s, a)                  # Use generative model to get the next state and reward
    q = r + g*simulate!(sp, d-1, m, N, Q, T)        # Recursive call
    N[(s,a)] += 1                                   # Explored node, update count
    Q[(s,a)] += (q-Q[(s,a)])/N[(s,a)]               # Update Q
    return q
end

# These would be appropriate containers for your Q, N, and t dictionaries:
N = Dict{Tuple{S, A}, Int}()
Q = Dict{Tuple{S, A}, Float64}()
T = Dict{Tuple{S, A, S}, Int}()

# Run 7 times
s = SA[19,19]
d = 10
for _ in 1:7
    simulate!(s, d, m, N, Q, T)
end

inchrome(visualize_tree(Q, N, T, SA[19,19])) # use inbrowser(visualize_tree(q, n, t, SA[1,1]), "firefox") etc. if you want to use a different browser




# This is an example state - it is a StaticArrays.SVector{2, Int}
# s = SA[19,19]
# @show typeof(s)
# @assert s isa statetype(m)






# here is an example of how to visualize a dummy tree (q, n, and t should actually be filled in your mcts code, but for this we fill it manually)
# q[(SA[1,1], :right)] = 0.0
# q[(SA[2,1], :right)] = 0.0
# n[(SA[1,1], :right)] = 1
# n[(SA[2,1], :right)] = 0
# t[(SA[1,1], :right, SA[2,1])] = 1

# inchrome(visualize_tree(q, n, t, SA[1,1])) # use inbrowser(visualize_tree(q, n, t, SA[1,1]), "firefox") etc. if you want to use a different browser





# ############
# # Question 4
# ############

#A starting point for the MCTS select_action function which can be used for Questions 4 and 5
function select_action(m, s)

    start = time_ns()
    n = Dict{Tuple{statetype(m), actiontype(m)}, Int}()
    q = Dict{Tuple{statetype(m), actiontype(m)}, Float64}()


    for _ in 1:1000
    # while time_ns() < start + 40_000_000 # you can replace the above line with this if you want to limit this loop to run within 40ms
        break # replace this with mcts iterations to fill n and q
    end

    # select a good action based on q and/or n

    return rand(actions(m)) # this dummy function returns a random action, but you should return your selected action
end

#@btime select_action(m, SA[35,35]) # you can use this to see how much time your function takes to run. A good time is 10-20ms.

# ############
# # Question 5
# ############

# HW3.evaluate(select_action, "your.gradescope.email@colorado.edu")

# # If you want to see roughly what's in the evaluate function (with the timing code removed), check sanitized_evaluate.jl

# ########
# # Extras
# ########

# # With a typical consumer operating system like Windows, OSX, or Linux, it is nearly impossible to ensure that your function *always* returns within 50ms. Do not worry if you get a few warnings about time exceeded.

# # You may wish to call select_action once or twice before submitting it to evaluate to make sure that all parts of the function are precompiled.

# # Instead of submitting a select_action function, you can alternatively submit a POMDPs.Solver object that will get 50ms of time to run solve(solver, m) to produce a POMDPs.Policy object that will be used for planning for each grid world.