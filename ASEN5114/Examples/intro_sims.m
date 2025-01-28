% introductory simulation examples for ASEN 4114/5114
% updated 8/26/2018 DAL
%  - model climb rate instead of altitude
%  - add elevator defl to all plots

t = linspace(0,30,1000)'; % time vector for simulation

% Simple plant (no disturbances or non-zero initial conditions).
%   Note output does not match input, but is proportional 
%  (after a several second settling time).
num0 = [0 .4];  % numerator Laplace transform polynomial
den0 = conv([1 .3],[1/10 1]); % denominator Laplace transform polynomial
[A0,B0,C0,D0]=tf2ss(num0,den0); % convert transfer function to a state space model
IC0 = 0;    % set initial conditions to zero
open_system('plant0')   % use the simulink system plant0
u = ones(size(t)); % define elevator input (control)
% simulate the action of this input on the plant to produce the output signal
[t,x,climbrate0] = ...
    sim('plant0',t,[],[t,u]);   % climbrate0 is the output (signal we care about)

figure(1)
clf
plot(t,climbrate0,'LineWidth',1.5)
hold on
plot(t,u,'g','LineWidth',1.5)
xlabel('Time, [sec]')
ylabel('Signal Amplitude')
legend('Climb Rate [m/s]','Elevator Deflection [deg]')
axis([t(1)-1 t(length(t)) -0.5 2.5])
title('Uncontrolled Plant Step Response')


R = input('Hit any key to continue');

% Feed forward controller without disturbances (sinulink system control0).
%   This can correct for the wrong DC gain from input to output.
nc0 = [3];
dc0 = [4];
open_system('control0')
r = ones(size(t)); % reference climb rate (command or desired output)
u = r*nc0/dc0;
options = [];
[t,x,climbrate] = ...
    sim('control0',t,options,[t,r]); % climbrate is the output here

figure(2)
clf
plot(t,climbrate,'LineWidth',1.5)
hold on
plot(t,u,'g','LineWidth',1.5)
plot(t,r,'r','LineWidth',1.5)
xlabel('Time, [sec]')
ylabel('Signal Amplitude')
legend('Climb Rate [m/s]','Elevator Deflection [deg]','Reference Climb Rate [m/s]')
axis([t(1)-1 t(length(t)) -0.5 2.5])
title('Simple Feed Forward Controlled Plant Step Response')


R = input('Hit any key to continue');

% Add non-zero initial conditions.
%   Note this does not affect the static accuracy: we will see later why.
IC0 = 0.4/C0(2);
[t,x,climbrate] = ...
    sim('control0',t,options,[t,r]);

figure(3)
clf
plot(t,climbrate,'LineWidth',1.5)
hold on
plot(t,u,'g','LineWidth',1.5)
plot(t,r,'r','LineWidth',1.5)
xlabel('Time, [sec]')
ylabel('Signal Amplitude')
legend('Climb Rate [m/s]','Elevator Deflection [deg]','Reference Climb Rate [m/s]')
axis([t(1)-1 t(length(t)) -0.5 2.5])
title('Simple Feed Forward Controlled Plant Step Response, Non-Zero ICs')


R = input('Hit any key to continue');

% Add aerodynamic disturbances (simulink system control1).
%   Note that the feedforward controller cannot mitigate disturbances.
open_system('control1')
IC0 = 0.4/C0(2);
[t,x,climbrate] = ...
    sim('control1',t,options,[t,r]);

figure(4)
clf
plot(t,climbrate,'LineWidth',1.5)
hold on
plot(t,u,'g','LineWidth',1.5)
plot(t,r,'r','LineWidth',1.5)
xlabel('Time, [sec]')
ylabel('Signal Amplitude')
legend('Climb Rate [m/s]','Elevator Deflection [deg]','Reference Climb Rate [m/s]')
axis([t(1)-1 t(length(t)) -0.5 2.5])
title('Feed Forward Controlled Plant Step Response, Aerodynamic Dist.')

R = input('Hit any key to continue');

% Try a more sophisticated feedforward controller (that tries to not only 
%   invert the DC gain, but also some of the dynamics) by
%   canceling the low frequency pole, and replacing it with a higher
%   frequency one.
%   Note this improves the transient response to the input, but does not
%   improve the disturbance response.
open_system('control2');
nc2 = 3*10/4*[1 0.3];
dc2 = [1 3];

[t,x,climbrate,elev_defl] = ...
    sim('control2',t,options,[t,r]);

figure(5)
clf
plot(t,climbrate,'LineWidth',1.5)
hold on
plot(t,elev_defl,'g','LineWidth',1.5)
plot(t,r,'r','LineWidth',1.5)
xlabel('Time, [sec]')
ylabel('Signal Amplitude')
legend('Climb Rate [m/s]','Elevator Deflection [deg]','Reference Climb Rate [m/s]')
axis([t(1)-1 t(length(t)) -0.5 2.5])
title('Dynamic Feed Forward Controlled Plant Step Response')

R = input('Hit any key to continue');

% try a feedback controller, use different gains to explore stability
% implications
%   note that feedback can improve the tracking and disturbance responses,
%   but higher gains cause an instability to occur
open_system('control3');
nc3 = 1*[1];
nc3 = 5*[1]; 
nc3 = 10*[1]; 
nc3 = 20*[1]; 
dc3 = [1/20 1];
Kff = (1 + 4*nc3/3)/(4*nc3/3);

[t,x,climbrate,elev_defl] = ...
    sim('control3',t,options,[t,r]);

figure(6)
clf
plot(t,climbrate,'LineWidth',1.5)
hold on
plot(t,elev_defl,'g','LineWidth',1.5)
plot(t,r,'r','LineWidth',1.5)
xlabel('Time, [sec]')
ylabel('Signal Amplitude')
legend('Climb Rate [m/s]','Elevator Deflection [deg]','Reference Climb Rate [m/s]')
axis([t(1)-1 t(length(t)) -0.5 2.5])
title('Feedback Controlled Plant Step Response')
