using DMUStudent.HW2
#using POMDPs: states, actions, transition, support
using POMDPs
using POMDPTools: ordered_states
using LinearAlgebra

##############
# Instructions
##############
#=

This starter code is here to show examples of how to use the HW2 code that you
can copy and paste into your homework code if you wish. It is not meant to be a
fill-in-the blank skeleton code, so the structure of your final submission may
differ from this considerably.

=#

############
# Question 3
############
m = grid_world # Grid world object
@show actions(m) # prints the actions. In this case each action is a Symbol. Use ?Symbol to find out more.

T = transition_matrices(m)
display(T) # this is a Dict that contains a transition matrix for each action

@show T[:left][1, 2] # the probability of transitioning between states with indices 1 and 2 when taking action :left

R = reward_vectors(m)
display(R) # this is a Dict that contains a reward vector for each action

@show R[:right][1] # the reward for taking action :right in the state with index 1






function value_iteration(m)
    # It is good to put performance-critical code in a function: https://docs.julialang.org/en/v1/manual/performance-tips/
    # Setup
    T = transition_matrices(m)  # Transition matrix
    R = reward_vectors(m)       # Reward vector
    A = collect(actions(m))     # Action vector

    V = rand(length(states(m)))         # Containers for the two value functions
    Vp = rand(length(states(m)))

    # Set tolerance and discount values
    epsilon = 1E-3
    g = 0.95

    # Conduct value iteration
    while (norm(V - Vp) > epsilon) # Keep going until the tolerance is met
        V = Vp     # Update value function

        # Bellman's equation
        for (i, s) in enumerate(states(m))  # Iterate through all states
            
            q = zeros(length(A))            # Empty vector for the utility of all the actions
            sInd = stateindex(m,s)          # Index for the current state

            for (j, a) in enumerate(A)      # Iterate through all possible actions at the given state
                td = transition(m, s, a)    # Transition probability at the give state
                r = R[a]                    # Reward vector for the current action

                q[j] += r[sInd]             # Reward for the current state and action
                for sp in support(td)       # Iterate over all next possible states
                    spInd = stateindex(m, sp)   # Index for the next state
                    q[j] += g * T[a][sInd, spInd] * Vp[spInd]   # Discount, transition probability, and value of the next state
                end
            end

            Vp[i] = maximum(q)  # Update value with the maximum utility across all actions             
        end
    end

    return V
end



V = value_iteration(m)

# You can use the following commented code to display the value. If you are in an environment with multimedia capability (e.g. Jupyter, Pluto, VSCode, Juno), you can display the environment with the following commented code. From the REPL, you can use the ElectronDisplay package.
display(render(grid_world, color=V))
#@show HW2.evaluate(V)






############
# Question 4
############

# # You can create an mdp object representing the problem with the following:
# m = UnresponsiveACASMDP(2)

# # transition_matrices and reward_vectors work the same as for grid_world, however this problem is much larger, so you will have to exploit the structure of the problem. In particular, you may find the docstring of transition_matrices helpful:
# display(@doc(transition_matrices))

# V = value_iteration(m)

# @show HW2.evaluate(V)

# ########
# # Extras
# ########

# # The comments below are not needed for the homework, but may be helpful for interpreting the problems or getting a high score on the leaderboard.

# # Both UnresponsiveACASMDP and grid_world implement the POMDPs.jl interface. You can find complete documentation here: https://juliapomdp.github.io/POMDPs.jl/stable/api/#Model-Functions

# # To convert from physical states to indices in the transition function, use the stateindex function
# # IMPORTANT NOTE: YOU ONLY NEED TO USE STATE INDICES FOR THIS ASSIGNMENT, using the states may help you make faster specialized code for the ACAS problem, but it is not required
# using POMDPs: states, stateindex

# s = first(states(m))
# @show si = stateindex(m, s)

# # To convert from a state index to a physical state in the ACAS MDP, use convert_s:
# using POMDPs: convert_s

# @show s = convert_s(ACASState, si, m)

# # To visualize a state in the ACAS MDP, use
# render(m, (s=s,))