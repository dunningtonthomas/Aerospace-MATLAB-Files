function [Arat] = Astar(M,g)

%Area over A star ratio for a given mach number
Arat = 1 / M * (2/(g+1) * (1 + (g-1)/2 * M^2))^((g+1)/(2*(g-1)));

end

