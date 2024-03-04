using DMUStudent.HW4
#using POMDPs: actions, @gen, isterminal, discount, statetype, actiontype, simulate, states, initialstate, support
using CommonRLInterface
using Statistics: mean, std



############ SARSA Implementation ###################

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
        push!(episodes, sarsa_episode!(Q, env; epsilon=max(0.1, 1-i/n_episodes)))
    end
    
    return episodes
end



## Main

# Simple grid world
m = HW4.gw
env = convert(AbstractEnv, m)
#HW4.render(m)

sarsa_episodes = sarsa!(env, n_episodes=10000);


finalEp = sarsa_episodes[length(sarsa_episodes)];
HW4.render(m, color=s->maximum(map(a->finalEp.Q[(s,a)], actions(env))))

