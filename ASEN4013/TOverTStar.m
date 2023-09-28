function [Mach] = TOverTStar(ToTstar, g)
    %Define boundary values
    xLow = 0;
    xUpp = 3;
    tol = 1e-9;
    
    %Define equation
    tRatioFunc = @(M)(2*(g + 1).*M.^2).*(1+(g-1)/2 .* M.^2) ./ (1 + g*M.^2).^2 - ToTstar; %Equation for Tt over Ttstar

    %Root solve for the mach number
    %Mach = rootSolve(tRatioFunc, xLow, xUpp, tol);
    Mach = fzero(tRatioFunc, 0.4);

end

