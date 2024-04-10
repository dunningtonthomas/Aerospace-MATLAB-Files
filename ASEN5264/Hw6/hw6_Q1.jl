using POMDPs
using DMUStudent.HW6
using POMDPTools: transition_matrices, reward_vectors, SparseCat, Deterministic, RolloutSimulator, DiscreteBelief, FunctionPolicy, ordered_states, ordered_actions, DiscreteUpdater
using QuickPOMDPs: QuickPOMDP
using POMDPModels: TigerPOMDP, TIGER_LEFT, TIGER_RIGHT, TIGER_LISTEN, TIGER_OPEN_LEFT, TIGER_OPEN_RIGHT
using NativeSARSOP: SARSOPSolver
using POMDPTesting: has_consistent_distributions
using LinearAlgebra


##################
# Problem 1: Tiger
##################

#--------
# Updater
#--------

# Note: you can access the transition and observation probabilities through the POMDPs.transtion and POMDPs.observation, and query individual probabilities with the pdf function. For example if you want to use more mathematical-looking functions, you could use the following:
# Z(o | a, s') can be programmed with
Z(m::POMDP, a, sp, o) = pdf(observation(m, a, sp), o)
# T(s' | s, a) can be programmed with
T(m::POMDP, s, a, sp) = pdf(transition(m, s, a), sp)
# POMDPs.transtion and POMDPs.observation return distribution objects. See the POMDPs.jl documentation for more details.


struct HW6Updater{M<:POMDP} <: Updater
    m::M
end

function POMDPs.update(up::HW6Updater, b::DiscreteBelief, a, o)
    stateVec = collect(ordered_states(up.m))
    bp_vec = zeros(length(stateVec))
    bp_vec[1] = 1.0
    # Probability functions
    Z(m::POMDP, a, sp, o) = pdf(observation(m, a, sp), o)
    T(m::POMDP, s, a, sp) = pdf(transition(m, s, a), sp)

    # Note that the ordering of the entries in bp_vec must be consistent with stateindex(m, s) (the container returned by states(m) does not necessarily obey this order)
    for (i, sp) in enumerate(stateVec)
        bp_vec[i] = Z(up.m, a, sp, o)*sum(s -> T(up.m, s, a, sp)*pdf(b, s), stateVec)
    end
    bp_vec = bp_vec ./ sum(bp_vec)
    return DiscreteBelief(up.m, bp_vec)
end


# This is needed to automatically turn any distribution into a discrete belief.
function POMDPs.initialize_belief(up::HW6Updater, distribution::Any)
    b_vec = zeros(length(states(up.m)))
    for s in states(up.m)
        b_vec[stateindex(up.m, s)] = pdf(distribution, s)
    end
    return DiscreteBelief(up.m, b_vec)
end

# Note: to check your belief updater code, you can use POMDPTools: DiscreteUpdater. It should function exactly like your updater.

#-------
# Policy
#-------

struct HW6AlphaVectorPolicy{A} <: Policy
    alphas::Vector{Vector{Float64}}
    alpha_actions::Vector{A}
end

function POMDPs.action(p::HW6AlphaVectorPolicy, b::DiscreteBelief)
    # Initialize the belief distribution and the alpha vectors
    beliefvec(b::DiscreteBelief) = b.b
    # More compact:
    i = argmax([dot(alpha, beliefvec(b)) for alpha in p.alphas])
    return p.alpha_actions[i]

    # alphaVecs = p.alphas
    # alphaActions = p.alpha_actions
    # best_action = 0
    # best_value = -Inf

    # # Maximize the dot product of the alpha vector and the belief vector
    # for (i, alphaVec) in enumerate(alphaVecs)
    #     action_value = dot(alphaVec, beliefvec(b))

    #     # Update best action and values
    #     if action_value > best_value
    #         best_value = action_value
    #         best_action = i
    #     end
    # end   
    # return alphaActions[best_action]
end

beliefvec(b::DiscreteBelief) = b.b # this function may be helpful to get the belief as a vector in stateindex order

#------
# QMDP
#------

function qmdp_solve(m, discount=discount(m))
    # Value Iteration to compute the Q-values
    Ts = transition_matrices(m, sparse=true)
    Rs = reward_vectors(m)
    n = length(first(values(Rs)))
    V = zeros(n)
    oldV = ones(n)
    while maximum(abs, V-oldV) > 1e-3   # Tolerance
        oldV[:] = V
        V[:] = max.((Rs[a] + discount*Ts[a]*V for a in keys(Rs))...)
    end


    # Compute the alpha vectors using the calculated value function
    acts = actiontype(m)[]
    alphas = Vector{Float64}[]
    for a in ordered_actions(m)
        push!(acts, a)  # Add the action
        alpha = zeros(length(states(m)))

        # Fill in alpha vector calculation
        # Note that the ordering of the entries in the alpha vectors must be consistent with stateindex(m, s) (states(m) does not necessarily obey this order, but ordered_states(m) does.)
        for (i, s) in enumerate(ordered_states(m))
            alpha[stateindex(m, s)] = reward(m, s, a) + discount * sum(T(m, s, a, sp) * V[stateindex(m, s)] for sp in ordered_states(m))             
        end
        push!(alphas, alpha)
    end
    return HW6AlphaVectorPolicy(alphas, acts)
end


# POMDP definition
m = TigerPOMDP()

qmdp_p = qmdp_solve(m)
# Note: you can use the QMDP.jl package to verify that your QMDP alpha vectors are correct.
sarsop_p = solve(SARSOPSolver(), m)

# Test the updaters
up = HW6Updater(m)
up2 = DiscreteUpdater(m)

# Test the policy and action function --> Call the action function based on an initial belief and state

@show mean(simulate(RolloutSimulator(max_steps=500), m, qmdp_p, up) for _ in 1:5000)
@show mean(simulate(RolloutSimulator(max_steps=500), m, sarsop_p, up) for _ in 1:5000)
#@show mean(simulate(RolloutSimulator(max_steps=500), m, sarsop_p, up2) for _ in 1:5000)
