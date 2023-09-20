function nu = NuFromM(M)
%Returns the prandlt meyer expansion nu from a given M
g = 1.4;

nu = sqrt((g+1)/(g-1)) * atan(sqrt((g-1)*(M^2-1)/(g+1))) - atan(sqrt(M^2-1));

end

