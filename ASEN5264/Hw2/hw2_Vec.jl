using DMUStudent.HW2
#using POMDPs: states, actions, transition, support
using POMDPs
using POMDPTools: ordered_states
using LinearAlgebra


############
# Question 3
############

# Function that conducts value iteration and returns the optimal value function
function value_iteration(m, g, epsilon)
    # It is good to put performance-critical code in a function: https://docs.julialang.org/en/v1/manual/performance-tips/
    # Setup
    T = transition_matrices(m; sparse=true)          # Transition matrix
    R = reward_vectors(m)               # Reward vector
    A = collect(actions(m))             # Action vector

    V = ones(length(states(m)))         # Containers for the two value functions
    Vp = -100 * ones(length(states(m)))

    # Conduct value iteration
    while (norm(V - Vp) > epsilon)      # Keep going until the tolerance is met
        V = copy(Vp)                    # Update value function, use copy to create new storage

        for a in A                      # Iterate through all possible actions at the given state
            td = T[a]                   # Transition matrix for the given action
            r = R[a]                    # Reward vector for the current action
            q = r + g * td * Vp         # Bellman operator
            Vp = max.(Vp, q)            # Take the maximum
        end
    end

    return V
end

# Grid world object
m = grid_world 

# Set tolerance and discount values
epsilon = 1E-6
g = 0.95

# Call the function with our simple grid world
V = value_iteration(m, g, epsilon)

# Display the grid
display(render(grid_world, color=V))

#@show HW2.evaluate(V)



############
# Question 4
############

# You can create an mdp object representing the problem with the following:
m = UnresponsiveACASMDP(10)

# transition_matrices and reward_vectors work the same as for grid_world, however this problem is much larger, so you will have to exploit the structure of the problem. In particular, you may find the docstring of transition_matrices helpful:
#display(@doc(transition_matrices))

# R = reward_vectors(m)
# T = transition_matrices(m; sparse=true)

# Set tolerance and discount values
epsilon = 1E-6
g = 0.99

# Call value iteration
V = value_iteration(m, g, epsilon)

# Evaluate
HW2.evaluate(V, "thomas.dunnington@colorado.edu")

########
# Extras
########

# The comments below are not needed for the homework, but may be helpful for interpreting the problems or getting a high score on the leaderboard.

# Both UnresponsiveACASMDP and grid_world implement the POMDPs.jl interface. You can find complete documentation here: https://juliapomdp.github.io/POMDPs.jl/stable/api/#Model-Functions

# To convert from physical states to indices in the transition function, use the stateindex function
# IMPORTANT NOTE: YOU ONLY NEED TO USE STATE INDICES FOR THIS ASSIGNMENT, using the states may help you make faster specialized code for the ACAS problem, but it is not required
# using POMDPs: states, stateindex

# s = first(states(m))
# @show si = stateindex(m, s)

# # To convert from a state index to a physical state in the ACAS MDP, use convert_s:
# using POMDPs: convert_s

# @show s = convert_s(ACASState, si, m)

# # To visualize a state in the ACAS MDP, use
# render(m, (s=s,))