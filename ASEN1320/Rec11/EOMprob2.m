function f = EOMprob2(t,xstate,m)

    x1dot = xstate(2);
    x2dot = (5 + xstate(1)^2 - xstate(2)*exp(xstate(1)))/m;

    f = [x1dot;x2dot];
end