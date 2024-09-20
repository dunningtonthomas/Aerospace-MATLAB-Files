%% Clean up
close all; clear; clc;


%% Problem 1
dt = 10;
k = 398600;
r0 = 6678;
w0 = sqrt(k / r0^3);

A = [0, 1, 0, 0; w0^2 + 2*k/r0^3, 0, 0, 2*r0*w0; 0, 0, 0, 1; 0, -2*w0/r0, 0, 0];
B = [0, 0; 1, 0; 0, 0; 0, 1/r0];

F = expm(A*dt);

% Augmented matrix
Ahat = [A, B; zeros(2, length(A(1,:)) + length(B(1,:)))];

% Matrix exponential
expAhat = expm(Ahat*dt);


%
A = [0, 1, 0; 0, 0, 1; 0, 0, 0];
Q = [1,1,1;0,0,0;0,0,0];

[vals, vec] = eig(A);

%% Problem 4
F = expAhat(1:4,1:4);
G = expAhat(1:4, 5:6);
H = [1,0,0,0; 0,0,1,0];
M = [0,0;0,0];
dt = 10;
T = 2*pi / w0;
times = 0:dt:T;
u = zeros(length(times), 2);

% Initial conditions
state_init = [10; -0.5; 0; 2.5e-5];

state_space = ss(F,G,H,M,dt);

% Simulate pertubations
[yout, tout, xout] = lsim(state_space, u, times, state_init);

% Calculate the full state trajectories
x_full = zeros(length(tout), 4);
x_full(:,1) = r0 + xout(:,1);
x_full(:,2) = xout(:,2);
x_full(:,3) = w0*tout + xout(:,3);
x_full(:,4) = w0 + xout(:,4);

% Get x,y positions
x_pos = x_full(:,1) .* cos(x_full(:,3));
y_pos = x_full(:,1) .* sin(x_full(:,3));

% Full nonlinear ODE sim
u_ode = zeros(2, 1);
EOM_obj = @(t, x)satEOM(t, x, u_ode, k);

% Ode45
ode_init = state_init + [r0; 0; 0; w0];
tspan = 0:10:T;
options = odeset('RelTol', 1e-9, 'AbsTol', 1e-9);
[TOUT, XOUT] = ode45(EOM_obj, tspan, ode_init, options);

% Calculate the pertubations
XPERT = XOUT;
XPERT(:,1) = XPERT(:,1) - r0;
XPERT(:,3) = XPERT(:,3) - w0*TOUT;
XPERT(:,4) = XPERT(:,4) - w0;


% Calculate the difference between the linear and nonlinear results
x_pert_diff = (XPERT - xout);
x_full_diff = (x_full - XOUT);


%% Plotting
set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'DefaultAxesTickLabelInterpreter', 'latex');
set(groot, 'DefaultLegendInterpreter', 'latex');

% Pertubations over time
figure();
sgtitle('State Pertubations Over Time')
subplot(4,1,1);
plot(tout, xout(:,1), 'LineWidth', 2, 'Color', 'r');
xlabel('Time (s)')
ylabel('$\Delta r$ (km)')

subplot(4,1,2);
plot(tout, xout(:,2), 'LineWidth', 2, 'Color', 'r');
xlabel('Time (s)')
ylabel('$\Delta \dot{r} (km/s)$')

subplot(4,1,3);
plot(tout, xout(:,3), 'LineWidth', 2, 'Color', 'r');
xlabel('Time (s)')
ylabel('$\Delta\theta$ (rad)')

subplot(4,1,4);
plot(tout, xout(:,4), 'LineWidth', 2, 'Color', 'r');
xlabel('Time (s)')
ylabel('$\Delta\dot{\theta}$ (rad/s)')

% Total state trajectories
figure();
sgtitle('Full State Over Time')
subplot(4,1,1);
plot(tout, x_full(:,1), 'LineWidth', 2, 'Color', 'b');
xlabel('Time (s)')
ylabel('$r$ (km)')

subplot(4,1,2);
plot(tout, x_full(:,2), 'LineWidth', 2, 'Color', 'b');
xlabel('Time (s)')
ylabel('$\dot{r} (km/s)$')

subplot(4,1,3);
plot(tout, x_full(:,3), 'LineWidth', 2, 'Color', 'b');
xlabel('Time (s)')
ylabel('$\theta$ (rad)')

subplot(4,1,4);
plot(tout, x_full(:,4), 'LineWidth', 2, 'Color', 'b');
xlabel('Time (s)')
ylabel('$\dot{\theta}$ (rad/s)')

% Trajectory
% figure();
% plot(x_pos, y_pos, 'LineWidth',2, 'Color', 'm');


% Nonlinear plots
figure();
sgtitle('Nonlinear Full State Over Time')
subplot(4,1,1);
plot(TOUT, XOUT(:,1), 'LineWidth', 2, 'Color', 'b', 'LineStyle','--');
xlabel('Time (s)')
ylabel('$r$ (km)')

subplot(4,1,2);
plot(TOUT, XOUT(:,2), 'LineWidth', 2, 'Color', 'b', 'LineStyle','--');
xlabel('Time (s)')
ylabel('$\dot{r} (km/s)$')

subplot(4,1,3);
plot(TOUT, XOUT(:,3), 'LineWidth', 2, 'Color', 'b', 'LineStyle','--');
xlabel('Time (s)')
ylabel('$\theta$ (rad)')

subplot(4,1,4);
plot(TOUT, XOUT(:,4), 'LineWidth', 2, 'Color', 'b', 'LineStyle','--');
xlabel('Time (s)')
ylabel('$\dot{\theta}$ (rad/s)')


% Nonlinear Pertubations over time
figure();
sgtitle('Nonlinear State Pertubations Over Time')
subplot(4,1,1);
plot(TOUT, XPERT(:,1), 'LineWidth', 2, 'Color', 'r', 'LineStyle','--');
xlabel('Time (s)')
ylabel('$\Delta r$ (km)')

subplot(4,1,2);
plot(TOUT, XPERT(:,2), 'LineWidth', 2, 'Color', 'r', 'LineStyle','--');
xlabel('Time (s)')
ylabel('$\Delta \dot{r} (km/s)$')

subplot(4,1,3);
plot(TOUT, XPERT(:,3), 'LineWidth', 2, 'Color', 'r', 'LineStyle','--');
xlabel('Time (s)')
ylabel('$\Delta\theta$ (rad)')

subplot(4,1,4);
plot(TOUT, XPERT(:,4), 'LineWidth', 2, 'Color', 'r', 'LineStyle','--');
xlabel('Time (s)')
ylabel('$\Delta\dot{\theta}$ (rad/s)')


% Difference in pertubation
figure();
sgtitle('Linearization Error Over Time')
subplot(4,1,1);
plot(TOUT, x_pert_diff(:,1), 'LineWidth', 2, 'Color', 'k');
xlabel('Time (s)')
ylabel('ERROR $ r$ (km)')

subplot(4,1,2);
plot(TOUT, x_pert_diff(:,2), 'LineWidth', 2, 'Color', 'k');
xlabel('Time (s)')
ylabel('ERROR $ \dot{r} (km/s)$')

subplot(4,1,3);
plot(TOUT, x_pert_diff(:,3), 'LineWidth', 2, 'Color', 'k');
xlabel('Time (s)')
ylabel('ERROR $\theta$ (rad)')

subplot(4,1,4);
plot(TOUT, x_pert_diff(:,4), 'LineWidth', 2, 'Color', 'k');
xlabel('Time (s)')
ylabel('ERROR $\dot{\theta}$ (rad/s)')


%% Functions
function xdot = satEOM(t, x, u, k)
    % Unpack the state and control
    r = x(1);
    rdot = x(2);
    theta = x(3);
    thetadot = x(4);
    u1 = u(1);
    u2 = u(2);

    % Nonlinear equations
    rddot = r*thetadot^2 - k/r^2 + u1;
    thetaddot = -2*thetadot*rdot/r + 1/r *u2;

    % Full xdot
    xdot = [rdot; rddot; thetadot; thetaddot];
end