using DMUStudent.HW2
using POMDPs: states, actions, transition, support
using POMDPTools: ordered_states

#@show actions(grid_world) # prints the actions. In this case each action is a Symbol. Use ?Symbol to find out more.
#display(render(grid_world))

m = grid_world
T = transition_matrices(grid_world)
#display(T) # this is a Dict that contains a transition matrix for each action

#@show T[:left][1, 2] # the probability of transitioning between states with indices 1 and 2 when taking action :left

R = reward_vectors(grid_world)
display(R)

#@show R[:right][1] # the reward for taking action :right in the state with index 1

test = states(m)
A = collect(actions(m))     # Action vector

s = test[5]
a = A[2]

td = transition(m, s, a)
x1 = enumerate(A)




function value_iteration(m)
    # It is good to put performance-critical code in a function: https://docs.julialang.org/en/v1/manual/performance-tips/

    V = rand(length(states(m))) # this would be a good container to use for your value function
    V_prime = rand(length(states(m)))

    # put your value iteration code here

    return V
end



