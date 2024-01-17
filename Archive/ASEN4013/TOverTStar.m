function [Mach] = TOverTStar(ToTstar, g)
    %This function root solves for mach given a T over T star relationship
    %Define boundary values
    
    %Define equation
    tRatioFunc = @(M)(2*(g + 1).*M.^2).*(1+(g-1)/2 .* M.^2) ./ (1 + g*M.^2).^2 - ToTstar; %Equation for Tt over Ttstar

    %Root solve for the mach number
    %Mach = rootSolve(tRatioFunc, xLow, xUpp, tol);
    Mach = fzero(tRatioFunc, 0.4); %ADJUST THE GUESS

end

