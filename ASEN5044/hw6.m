%% Clean
close all; clear; clc;


%% Problem 1
A = [0, 1; -100, -10];
gamma = [0; 1];
dt = 0.2;
W = 10;

Z = dt .* [-A, gamma*W*gamma'; zeros(2,2), A'];
expmz = expm(Z);

F = expmz(3:4, 3:4)';
FinvQ = expmz(1:2, 3:4);

Q = F * FinvQ;


%% Problem 3
R = [8, 5.15, 6.5; 5.15, 5, -4.07; 6.5, -4.07, 50];

% Cholesky decomposition
Sv = chol(R, "lower");

% Mean value
mx = [1; 1; 1];


numMeas = 100000;
yk = zeros(numMeas, 3);
for i = 1:numMeas
    qk = randn(3, 1);
    yk(i,:) = (mx + Sv*qk)';
end

% Calculate the covariance of the measurements
covMat = cov(yk);

% Plotting
% figure();
% scatter(yk(:,1), yk(:,2), 'filled', 'color', 'r');
% xlabel('X1 (Xi) [m]')
% ylabel('X2 (Eta) [m]')
% title('Xi vs Eta Position')
% axis equal

% Plotting
%%%%%%%%%%%%%%%% xi vs eta
figure();
scatter(yk(:,1), yk(:,2), 'filled', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k'); % red markers with black edge
hold on
scatter(1, 1, 'filled', 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'g');
xlabel('$y_{k}(1) (\xi)$ [m]', 'Interpreter', 'latex', 'FontSize', 14); % Greek letter Xi
ylabel('$y_{k}(2) (\eta)$ [m]', 'Interpreter', 'latex', 'FontSize', 14); % Greek letter Eta
title('$\xi$ vs $\eta$ Position', 'Interpreter', 'latex', 'FontSize', 16);

% Set grid and axis properties
grid on;
axis equal; % Equal scaling for both axes
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.2;

% Adjust axis limits and add minor grid lines
xlim([min(yk(:,1)) - 0.1, max(yk(:,1)) + 0.1]); % Adding padding
ylim([min(yk(:,2)) - 0.1, max(yk(:,2)) + 0.1]);
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';

% Add legend if needed
legend('measurement', '$m_{y}$', 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'best');

%%%%%%%%%%%%%%%% xi vs z
figure();
scatter(yk(:,1), yk(:,3), 'filled', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k'); % red markers with black edge
hold on
scatter(1, 1, 'filled', 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'g');
xlabel('$y_{k}(1) (\xi)$ [m]', 'Interpreter', 'latex', 'FontSize', 14); % Greek letter Xi
ylabel('$y_{k}(3) (z)$ [m]', 'Interpreter', 'latex', 'FontSize', 14); % Greek letter Eta
title('$\xi$ vs $z$ Position', 'Interpreter', 'latex', 'FontSize', 16);

% Set grid and axis properties
grid on;
axis equal; % Equal scaling for both axes
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.2;

% Adjust axis limits and add minor grid lines
% xlim([min(yk(:,1)) - 0.1, max(yk(:,1)) + 0.1]); % Adding padding
xlim([min(yk(:,3)) - 0.1, max(yk(:,3)) + 0.1]); % Adding padding
ylim([min(yk(:,3)) - 0.1, max(yk(:,3)) + 0.1]);
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';

% Add legend if needed
legend('measurement', '$m_{y}$', 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'best');




%%%%%%%%%%%%%%%% eta vs z
figure();
scatter(yk(:,2), yk(:,3), 'filled', 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k'); % red markers with black edge
hold on
scatter(1, 1, 'filled', 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'g');
xlabel('$y_{k}(2) (\eta)$ [m]', 'Interpreter', 'latex', 'FontSize', 14); % Greek letter Xi
ylabel('$y_{k}(3) , (z)$ [m]', 'Interpreter', 'latex', 'FontSize', 14); % Greek letter Eta
title('$\eta$ vs $z$ Position', 'Interpreter', 'latex', 'FontSize', 16);

% Set grid and axis properties
grid on;
axis equal; % Equal scaling for both axes
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.2;

% Adjust axis limits and add minor grid lines
%xlim([min(yk(:,2)) - 0.1, max(yk(:,2)) + 0.1]); % Adding padding
xlim([min(yk(:,3)) - 0.1, max(yk(:,3)) + 0.1]); % Adding padding
ylim([min(yk(:,3)) - 0.1, max(yk(:,3)) + 0.1]);
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';

% Add legend if needed
legend('measurement', '$m_{y}$', 'Interpreter', 'latex', 'FontSize', 12, 'Location', 'best');

