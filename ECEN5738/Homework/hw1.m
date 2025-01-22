%%
close all; clear; clc;

%% Problem 1
a = 10;
%xdotFunc = @(x)([-x(2) + a*x(1)*(x(1)^2 + x(2)^2); x(1) + a*x(2)*(x(1)^2 + x(2)^2)]);
xdotFunc = @(x)([x(1) + x(2); x(2)]);

% Create the meshgrid
x_vals = linspace(-1, 1, 20);
[X1, X2] = meshgrid(x_vals, x_vals);

% Calculate the phase portrait
x1dot = zeros(size(X1));
x2dot = zeros(size(X1));
for j = 1:numel(X1)
    % Calculate the rate of change
    xdot = xdotFunc([X1(j), X2(j)])';
    x1dot(j) = xdot(1);
    x2dot(j) = xdot(2);
end

% Plot the phase portrait
figure();
quiver(X1, X2, x1dot, x2dot, 'r', 'LineWidth', 2); % plot f(x) vector in phase plane
axis tight equal;


