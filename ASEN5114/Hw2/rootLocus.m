function rootLocus(poles)
%ROOTLOCUS Plots the poles in the complex plane
% Inputs:
%   poles -> NxM matrix of poles (N is arbitrary, M is the number of roots)
% Outputs:
%   A root locus figure
% 
% Author: Thomas Dunnington
% Last Modified: 2/4/2025

figure();
for i = 1:length(poles(1,:))
    scatter(real(poles(:,i)), imag(poles(:,i)), 100, 'Marker', 'x', 'LineWidth', 2);
end
xlabel('Real Axis', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('Imaginary Axis', 'FontSize', 12, 'FontWeight', 'bold')
title('Root Locus', 'FontSize', 14, 'FontWeight', 'bold')
grid on


end

