using DMUStudent.HW3: HW3, DenseGridWorld, visualize_tree
using POMDPs: actions, @gen, isterminal, discount, statetype, actiontype, simulate, states, initialstate, support
using D3Trees: inchrome, inbrowser
using StaticArrays: SA
using Statistics: mean
using BenchmarkTools: @btime

##############
# Scratch file to test components of hw3
##############


m = HW3.DenseGridWorld(seed = 3)


function rollout(mdp, heuristic_policy, s0, max_steps=100)
    # This function computes the reward returned from a stochastic rollout using a heuristic policy
    r_total = 0.0
    t = 0
    s = s0
    while !isterminal(mdp, s) && t < max_steps
        a = heuristic_policy(mdp, s)            # Use the heuristic policy to get the next action
        s, r = @gen(:sp, :r)(mdp, s, a)         # Use generative model to get the next state and reward
        r_total += discount(m)^t * r            # Accumulated discounted reward
        t += 1                                  # Update time step
    end

    return r_total  # Return the reward
end


function heuristic_policy(m, s)
    # put a smarter heuristic policy here
    return rand(actions(m))
end


# This code runs monte carlo simulations: you can calculate the mean and standard error from the results
@show results = [rollout(m, heuristic_policy, rand(initialstate(m))) for _ in 1:10]










