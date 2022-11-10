function xStateDot = diffEq2(t, xState, m)
    x1 = xState(1);
    x2 = xState(2);
    
    x1dot = x2;
    x2dot = (1/m)*(5 + x1^2 - x2*exp(x1));
    
    xStateDot = [x1dot; x2dot];

end

