using DMUStudent.HW4
using Plots
using CommonRLInterface
using Statistics: mean, std



############ Q Implementation ###################
function Q_episode!(Q, env; epsilon=0.10, gamma=0.99, alpha=0.2)
    start = time()
    
    function policy(s)
        if rand() < epsilon
            return rand(actions(env))
        else
            return argmax(a->Q[(s, a)], actions(env))
        end
    end

    s = observe(env)
    a = policy(s)
    r = act!(env, a)
    sp = observe(env)
    hist = [s]

    while !terminated(env)
        a = policy(s)
        r = act!(env, a)
        sp = observe(env)

        Q[(s,a)] += alpha*(r + gamma*maximum(Q[(sp, ap)] for ap in actions(env)) - Q[(s, a)])   # Update Q
        
        s = sp              # Update the state
        push!(hist, sp)     # Add to the history
    end

    Q[(s,a)] += alpha*(r - Q[(s, a)])   # Update Q

    return (hist=hist, Q = copy(Q), time=time()-start)
end


function Q!(env; n_episodes=100)
    Q = Dict((s, a) => 0.0 for s in observations(env), a in actions(env))
    episodes = []
    
    for i in 1:n_episodes
        reset!(env)
        push!(episodes, Q_episode!(Q, env; epsilon=max(0.1, 1-i/n_episodes), alpha=0.2))   # More explore at the beginning
        #push!(episodes, sarsa_episode!(Q, env; epsilon=0.1))   # Non decaying epsilon
    end
    
    return episodes
end


################## SARSA Learning ################################
function sarsa_episode!(Q, env; epsilon=0.10, gamma=0.99, alpha=0.2)
    start = time()
    
    function policy(s)
        if rand() < epsilon
            return rand(actions(env))
        else
            return argmax(a->Q[(s, a)], actions(env))
        end
    end

    s = observe(env)
    a = policy(s)
    r = act!(env, a)
    sp = observe(env)
    hist = [s]

    while !terminated(env)
        ap = policy(sp)

        Q[(s,a)] += alpha*(r + gamma*Q[(sp, ap)] - Q[(s, a)])

        s = sp
        a = ap
        r = act!(env, a)
        sp = observe(env)
        push!(hist, sp)
    end

    Q[(s,a)] += alpha*(r - Q[(s, a)])

    return (hist=hist, Q = copy(Q), time=time()-start)
end


function sarsa!(env; n_episodes=100)
    Q = Dict((s, a) => 0.0 for s in observations(env), a in actions(env))
    episodes = []
    
    for i in 1:n_episodes
        reset!(env)
        push!(episodes, sarsa_episode!(Q, env; epsilon=max(0.1, 1-i/n_episodes), alpha=0.2))   # More explore at the beginning
        #push!(episodes, sarsa_episode!(Q, env; epsilon=0.1))   # Non decaying epsilon
    end
    
    return episodes
end


# Evaluate will use a given policy from the episodes and return the undiscounted cumulative reward
function evaluate(env, policy; n_episodes=1000, max_steps=1000, gamma=1.0)
    returns = Float64[]
    for _ in 1:n_episodes
        t = 0
        r = 0.0
        reset!(env)
        s = observe(env)
        while !terminated(env)
            a = policy(s)
            r += gamma^t*act!(env, a)
            s = observe(env)
            t += 1
        end
        push!(returns, r)
    end
    return returns
end


## Main
# Simple grid world environment
m = HW4.gw
env = convert(AbstractEnv, m)

# Run SARSA
sarsa_episodes = sarsa!(env, n_episodes=100000);

# Run Q
Q_episodes = Q!(env, n_episodes=100000);

# Plot Results Create Dictionary
episodes = Dict("SARSA"=>sarsa_episodes, "Q Learning"=>Q_episodes)

# Create Steps in Environment Plot
p = plot(xlabel="Steps in Environment", ylabel="Avg Return")
p2 = plot(xlabel="Wall Clock Time", ylabel="Avg Return")
n = 1000
stop = 100000
numSteps = 0
for (name, eps) in episodes
    Q = Dict((s, a) => 0.0 for s in observations(env), a in actions(env))
    xs = [0]
    xs2 = [0.0]
    ys = [mean(evaluate(env, s->argmax(a->Q[(s, a)], actions(env))))]
    ys2 = [mean(evaluate(env, s->argmax(a->Q[(s, a)], actions(env))))]
    for i in n:n:min(stop, length(eps))
        newsteps = sum(length(ep.hist) for ep in eps[i-n+1:i])
        newtime = sum(ep.time for ep in eps[i-n+1:i])
        push!(xs, last(xs) + newsteps)
        push!(xs2, last(xs2) + newtime)
        Q = eps[i].Q
        push!(ys, mean(evaluate(env, s->argmax(a->Q[(s, a)], actions(env)))))
        push!(ys2, mean(evaluate(env, s->argmax(a->Q[(s, a)], actions(env)))))
    end    
    plot!(p, xs, ys, label=name)
    plot!(p2, xs2, ys2, label=name)
end

# Add horizontal line for the reward of 5
hline!(p, [5], line=:dash, label="Reward of 5")








