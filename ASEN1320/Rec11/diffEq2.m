function dxdt = diffEq2(t, stateVec, m)

    x1 = stateVec(1);
    x2 = stateVec(2);
    
    x1dot = x2;
    x2dot = (1/m)*(5 + x1^2 - x2 * exp(x1));
    
    dxdt = [x1dot; x2dot];
end

