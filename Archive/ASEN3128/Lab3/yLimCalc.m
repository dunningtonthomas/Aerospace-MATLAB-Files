function [yLimits] = yLimCalc(yData)
%YLIMCALC This function calculates the y limits of a plot by computing +5%
%of the maximum and -5% of the minimum so every point of the plot is in
%view

yUpper = max(yData) + 0.005*max(yData);
yLower = min(yData) - 0.005*min(yData);

yLimits = [yLower, yUpper];

end

