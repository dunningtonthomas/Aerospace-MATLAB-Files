function [M_sub M_sup] = nozzle(A_ratio)
% function [M_sub M_sup] = nozzle(A_ratio)
% takes in the Area ratio A/A* and returns the subsonic and sonic velocity

gamma = 1.4;

nozzle_eq =@(m) (1/m.^2)*((2/(gamma + 1))*...
    (1 + (gamma-1)*m.^2/2))^((gamma+1)/(gamma-1)) - A_ratio^2;

M_sub = fzero(nozzle_eq,[.01 1]);

M_sup = fzero(nozzle_eq,[1 70]);


end

