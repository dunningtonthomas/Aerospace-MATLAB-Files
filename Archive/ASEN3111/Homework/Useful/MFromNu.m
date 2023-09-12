function M = MFromNu(nu)
g = 1.4;
func = @(M)(sqrt((g+1)/(g-1)) * atan(sqrt((g-1)*(M^2-1)/(g+1))) - atan(sqrt(M^2-1)) - nu);

M = rootSolve(func, 0, 5, 1e-2);

end

