using POMDPs
using DMUStudent.HW6
using POMDPTools: transition_matrices, reward_vectors, SparseCat, Deterministic, RolloutSimulator, DiscreteBelief, FunctionPolicy, ordered_states, ordered_actions, DiscreteUpdater
using QuickPOMDPs: QuickPOMDP
using POMDPModels: TigerPOMDP, TIGER_LEFT, TIGER_RIGHT, TIGER_LISTEN, TIGER_OPEN_LEFT, TIGER_OPEN_RIGHT
using NativeSARSOP: SARSOPSolver
using POMDPTesting: has_consistent_distributions
using LinearAlgebra
using Plots
using Statistics: mean, std


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
    i = argmax([dot(alpha, beliefvec(b)) for alpha in p.alphas])
    return p.alpha_actions[i]
end

#------
# QMDP
#------

function qmdp_solve(m, discount=discount(m))
    T(m::POMDP, s, a, sp) = pdf(transition(m, s, a), sp)
    tol = 1e-6
    stateVec = ordered_states(m)
    actionVec = ordered_actions(m)
    Q = zeros(length(stateVec))
    del = Inf

    # Value iteration to solve for the Q values
    while del > tol
        del = 0
        for s in stateVec
            maxQ = -Inf
            v = Q[stateindex(m, s)]
            for a in actionVec
                Qval = reward(m, s, a) + discount * sum(T(m, s, a, sp) * Q[stateindex(m, sp)] for sp in stateVec) 
                maxQ = max(maxQ, Qval)            
            end
            Q[stateindex(m, s)] = maxQ
            del = max(del, abs(v - maxQ))
        end
    end

    # Compute the alpha vectors using the calculated value function
    acts = actiontype(m)[]
    alphas = Vector{Float64}[]
    for a in ordered_actions(m)
        alpha = zeros(length(states(m)))
        # Compute the alpha vectors
        for s in ordered_states(m)
            alpha[stateindex(m, s)] = reward(m, s, a) + discount * sum(T(m, s, a, sp) * Q[stateindex(m, sp)] for sp in ordered_states(m))             
        end
        push!(alphas, alpha)
        push!(acts, a)  # Add the action
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
qmdp_Results = (simulate(RolloutSimulator(max_steps=500), m, qmdp_p, up) for _ in 1:5000)
sarsop_Results = (simulate(RolloutSimulator(max_steps=500), m, sarsop_p, up) for _ in 1:5000)

# Standard error of the mean
qmdp_SEM = std(qmdp_Results) / sqrt(length(qmdp_Results))
sarsop_SEM = std(sarsop_Results) / sqrt(length(sarsop_Results))

# Print results
# @show mean(qmdp_Results)
# @show mean(sarsop_Results)
print("QMDP: \n", "\t Mean: ", mean(qmdp_Results), "\n\t SEM: ", qmdp_SEM, "\n")
print("SARSOP: \n", "\t Mean: ", mean(qmdp_Results), "\n\t SEM: ", qmdp_SEM, "\n")

# Plot the alpha vectors for QMDP
stateVec = 0:1
QMDP_Plot = plot(stateVec, qmdp_p.alphas[1], label="Listen", xlabel="Tiger Belief State, Left=0, Right=1", ylabel="Utility", title="QMDP Alpha Vectors")
plot!(QMDP_Plot, stateVec, qmdp_p.alphas[2], label="Open Left")
plot!(QMDP_Plot, stateVec, qmdp_p.alphas[3], label="Open Right")

# Plot the alpha vectors for SARSOPSolver
SARSOP_Plot = plot(stateVec, sarsop_p.alphas[1], label="Open Right", xlabel="Tiger Belief State, Left=0, Right=1", ylabel="Utility", title="SARSOP Alpha Vectors")
plot!(SARSOP_Plot, stateVec, sarsop_p.alphas[2], label="Listen")
plot!(SARSOP_Plot, stateVec, sarsop_p.alphas[3], label="Listen")
plot!(SARSOP_Plot, stateVec, sarsop_p.alphas[4], label="Open Left")
plot!(SARSOP_Plot, stateVec, sarsop_p.alphas[5], label="Listen")
plot!(SARSOP_Plot, stateVec, sarsop_p.alphas[6], label="Listen")




###################
# Problem 2: Cancer
###################

cancer = QuickPOMDP(
    states = [:healthy, :in_situ, :invasive, :death],
    actions = [:wait, :test, :treat],
    observations = [true, false],

    transition = function (s, a)
        if s == :healthy
            return SparseCat([:healthy, :in_situ], [0.98, 0.02])
        elseif s == :in_situ
            if a == :treat
                return SparseCat([:healthy, :in_situ], [0.6, 0.4])
            else
                return SparseCat([:in_situ, :invasive], [0.9, 0.1])
            end
        elseif s == :invasive
            if a == :treat
                return SparseCat([:healthy, :death, :invasive], [0.2, 0.2, 0.6])
            else
                return SparseCat([:invasive, :death], [0.4, 0.6])
            end
        else
            return Deterministic(:death)
        end
    end,

    observation = function (a, sp)
        if a == :test
            if sp == :healthy
                return SparseCat([true, false], [0.05, 0.95])
            elseif sp == :in_situ
                return SparseCat([true, false], [0.8, 0.2])
            else
                return Deterministic(true)
            end
        elseif a == :treat
            if sp in (:in_situ, :invasive)
                return Deterministic(true)
            end
        end
        return Deterministic(false)
    end,


    reward = function (s, a)
        if s == :death
            return 0.0
        elseif a == :wait
            return 1.0
        elseif a == :test
            return 0.8
        elseif a == :treat
            return 0.1
        end
    end,

    discount = 0.99,
    initialstate = Deterministic(:healthy),
    isterminal = s->s==:death,
)


@assert has_consistent_distributions(cancer)

m = cancer
qmdp_p = qmdp_solve(cancer)
sarsop_p = solve(SARSOPSolver(), cancer)
up = HW6Updater(cancer)
up = DiscreteUpdater(cancer)


heuristic = FunctionPolicy(
    function(b)
        # if pdf(b, :healthy) > 0.9
        #     return :wait
        # elseif pdf(b, :invasive) > 0.1
        #     return :test
        # elseif pdf(b, :in_situ) > 0.1
        #     return :test

        if pdf(b, :healthy) > 0.9
            return :test
        elseif pdf(b, :in_situ) > 0.9 && pdf(b, :invasive) > 0.7
            return :treat
        else
            return action(qmdp_p, b)
        end
                               # Fill in your heuristic policy here
                               # Use pdf(b, s) to get the probability of a state
                               
    end
)


@show mean(simulate(RolloutSimulator(), cancer, qmdp_p, up) for _ in 1:1000)     # Should be approximately 66
@show mean(simulate(RolloutSimulator(), cancer, heuristic, up) for _ in 1:1000)
@show mean(simulate(RolloutSimulator(), cancer, sarsop_p, up) for _ in 1:1000)   # Should be approximately 79

