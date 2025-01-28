close all; clear all; clc;

% interval: [-pi <= x <= 2*pi]

x = linspace(-pi, 2*pi, 100);
y = zeros(size(x)); 

for i = 1:length(x)
    for j = 1:length(x)
        if((j >= -pi) && (j <= -pi/2))
            y(i, j) = (-x(i).^3) - 33.4321;
        elseif((j < -pi/2) && (j <= 0))
            y(i,j) = tan(x(i));
        else((j<0) && (j <= 2*pi));
            y(i,j) = 0.1261.*(x(i).^3);
        end
    end
end

plot(x, y,'r');
grid on; 
title('Problem 1'); 
xlabel('x');
ylabel('y(x)');
ylim([-30 40]); 
