function [ M2 ] = PMeq_findM( v,guess )

g=1.4;
PMequation=@(M) v-sqrt((g+1)/(g-1))*...
    atan(sqrt((g-1)/(g+1)*(M.^2-1)))+atan(sqrt(M.^2-1));

% create a range of values, use this to find the first point 
% where PMequation is less than zero
inc = guess:.1:10;
I = find(PMequation(inc) < 0,1);
mach_end = inc(I);

% use the window created by mach end to solve for zero location
M2=fzero(PMequation,[guess mach_end]);

end

