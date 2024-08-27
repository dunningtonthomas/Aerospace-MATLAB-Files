using POMDPs
using DMUStudent.HW6
using POMDPTools: transition_matrices, reward_vectors, SparseCat, Deterministic, RolloutSimulator, DiscreteBelief, FunctionPolicy, ordered_states, ordered_actions, DiscreteUpdater
using QuickPOMDPs: QuickPOMDP
using POMDPModels: TigerPOMDP, TIGER_LEFT, TIGER_RIGHT, TIGER_LISTEN, TIGER_OPEN_LEFT, TIGER_OPEN_RIGHT
using NativeSARSOP: SARSOPSolver
using POMDPTesting: has_consistent_distributions
using Statistics: mean, std
using QMDP
using POMCPOW
using BasicPOMCP
using DiscreteValueIteration
using Random

#####################
# Problem 3: LaserTag
#####################
m = LaserTagPOMDP()
up = DiscreteUpdater(m) # you may want to replace this with your updater to test it

# POMCP, implemented in the BasicPOMCP.jl package:
function pomcp_solve(m) # this function makes capturing m in the rollout policy more efficient
    solver = POMCPSolver(tree_queries=100,
                         c=50.0,
                         max_depth=100,
                         default_action=first(actions(m)),
                         estimate_value=FOValue(ValueIterationSolver()))    # Use value iteration value estimator
    return solve(solver, m)
end

pomcp_p = pomcp_solve(m)

@show HW6.evaluate((pomcp_p, up), n_episodes=100)

# When you get ready to submit, use this version with the full 1000 episodes
# HW6.evaluate((pomcp_p, up), "thomas.dunnington@colorado.edu")

#----------------
# Visualization
# (all code below is optional)
#----------------

# You can make a gif showing what's going on like this:
using POMDPGifs
import Cairo, Fontconfig # needed to display properly

makegif(m, pomcp_p, up, max_steps=30, filename="lasertag.gif")

# You can render a single frame like this
using POMDPTools: stepthrough, render
using Compose: draw, PNG

history = []
for step in stepthrough(m, pomcp_p, up, max_steps=10)
    push!(history, step)
end
displayable_object = render(m, last(history))
# display(displayable_object) # <-this will work in a jupyter notebook or if you have vs code or ElectronDisplay
draw(PNG("lasertag.png"), displayable_object)