function MakePlots(a,c,fit)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

plot(a,c,'black.', a,fit, 'red-')
xlabel('Angle of Attack (degrees)')
ylabel('Coefficient of Lift, Cl')
title('NACA 4412 Airfoil')
legend('Experimental Data', 'Polynomial Fit Least-Squares','location','northwest')
grid on
end
