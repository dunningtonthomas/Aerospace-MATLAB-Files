function outVec = odeFun2(t, state)
    x1 = state(1);
    x2 = state(2);
    
    dx1dt = 0.5*x1 - 0.1*x2;
    dx2dt = 0.5*sqrt(t) + x1;
    
    outVec = [dx1dt; dx2dt]; %Must be column vector
end

