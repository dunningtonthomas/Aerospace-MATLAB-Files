using DMUStudent.HW2
using POMDPs: states, actions
using POMDPTools: ordered_states

@show actions(grid_world) # prints the actions. In this case each action is a Symbol. Use ?Symbol to find out more.

T = transition_matrices(grid_world)
display(T) # this is a Dict that contains a transition matrix for each action

