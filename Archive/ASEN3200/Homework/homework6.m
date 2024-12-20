%% Clean Up
close all; clear; clc;

%% Problem 2
%Constants
mu = 398600;

%Initial conditions
r0 = [7642; 170; 2186]; %km
rDot0 = [0.32; 6.91; 4.29]; %km/s

%Determine 1 orbital period:
%Approximate orbital period with radius as semi major axis
period = 2*pi*sqrt(norm(r0)^3 / mu);
tspan = [0 1.8*period];

%Creating function handle
orbitHandle = @(t, state)EOM(t, state, mu);

%Ode45
opts1 = odeset('RelTol',1e-3,'AbsTol',1e-3);
opts2 = odeset('RelTol',1e-6,'AbsTol',1e-6);
opts3 = odeset('RelTol',1e-12,'AbsTol',1e-12);
[TOUT1, YOUT1] = ode45(orbitHandle, tspan, [r0; rDot0], opts1);
[TOUT2, YOUT2] = ode45(orbitHandle, tspan, [r0; rDot0], opts2);
[TOUT3, YOUT3] = ode45(orbitHandle, tspan, [r0; rDot0], opts3);

%Computing the specific energy
v1 = YOUT1(:,4:end);
r1 = YOUT1(:,1:3);
speed1 = vecnorm(v1, 2, 2); 
dist1 = vecnorm(r1, 2, 2);
E1 = 0.5*speed1.^2 - mu ./ dist1;

v2 = YOUT2(:,4:end);
r2 = YOUT2(:,1:3);
speed2 = vecnorm(v2, 2, 2); 
dist2 = vecnorm(r2, 2, 2);
E2 = 0.5*speed2.^2 - mu ./ dist2;

v3 = YOUT3(:,4:end);
r3 = YOUT3(:,1:3);
speed3 = vecnorm(v3, 2, 2); 
dist3 = vecnorm(r3, 2, 2);
E3 = 0.5*speed3.^2 - mu ./ dist3;

%Computing the specific agular momentum
h1Vec = cross(r1, v1, 2);
h1 = vecnorm(h1Vec, 2, 2);

h2Vec = cross(r2, v2, 2);
h2 = vecnorm(h2Vec, 2, 2);

h3Vec = cross(r3, v3, 2);
h3 = vecnorm(h3Vec, 2, 2);

%Computing the eccentricity vector
e1Vec = (1/mu)*cross(v1, h1Vec, 2) - (1./vecnorm(r1, 2, 2)).*r1;
e1 = vecnorm(e1Vec, 2, 2);

e2Vec = (1/mu)*cross(v2, h2Vec, 2) - (1./vecnorm(r2, 2, 2)).*r2;
e2 = vecnorm(e2Vec, 2, 2);

e3Vec = (1/mu)*cross(v3, h3Vec, 2) - (1./vecnorm(r3, 2, 2)).*r3;
e3 = vecnorm(e3Vec, 2, 2);

%Creating sphere for the earth
[x,y,z] = sphere;
x = 6378*x;
y = 6378*y;
z = 6378*z;

%Plotting The orbit for one period
figure();
set(0, 'defaulttextinterpreter', 'latex');
plot3(YOUT1(:,1), YOUT1(:,2), YOUT1(:,3));
axis equal
hold on
grid on
surf(x,y,z);

xlabel('X Location (km)');
ylabel('Y Location (km)');
zlabel('Z Location (km)');
title('One Period Orbit');

%Plotting the specific energy over time
figure();
plot(TOUT1, E1, 'linewidth', 2);
hold on
plot(TOUT2, E2, 'linewidth', 2);
plot(TOUT3, E3, '--', 'linewidth', 2);

xlabel('Time (s)');
ylabel('Specific Energy (kJ/kg)');
title('Specific Energy Over Time');
legend('1e-3 Tolerance', '1e-6 Tolerance', '1e-12 Tolerance', 'location', 'best');

%Plotting the specific angular momentum over time
figure();
plot(TOUT1, h1, 'linewidth', 2);
hold on
plot(TOUT2, h2, 'linewidth', 2);
plot(TOUT3, h3, '--', 'linewidth', 2);

xlabel('Time (s)');
ylabel('Specific Angular Momentum $$(km^{2}/s)$$');
title('Specific Angular Momentum Over Time');
legend('1e-3 Tolerance', '1e-6 Tolerance', '1e-12 Tolerance', 'location', 'best');

%Plotting the eccentricity over time
figure();
plot(TOUT1, e1, 'linewidth', 2);
hold on
plot(TOUT2, e2, 'linewidth', 2);
plot(TOUT3, e3, '--', 'linewidth', 2);

xlabel('Time (s)');
ylabel('Eccentricity Magnitude');
title('Eccentricity Over Time');
legend('1e-3 Tolerance', '1e-6 Tolerance', '1e-12 Tolerance', 'location', 'best');

%% Problem 3
%Initial conditions spacecraft
r0 = [7642; 170; 2186]; %km
rDot0 = [0.32; 6.91; 4.29]; %km/s

%Initial conditions earth
r0e = [0; 0; 0];
rDot0e = [5; 5; 5];

period = 2*pi*sqrt(norm(r0)^3 / mu);
tspan = [0 3*period]; %5 orbital periods

%Creating function handle
orbitHandle2 = @(t, state)EOM2(t, state, mu);

%Calling ode45
[TOUT4, YOUT4] = ode45(orbitHandle2, tspan, [r0; rDot0; r0e; rDot0e], opts3);

%Plotting
figure();
plot3(YOUT4(:,7), YOUT4(:,8), YOUT4(:,9), 'linewidth', 2);
hold on
grid on
plot3(YOUT4(:,1), YOUT4(:,2), YOUT4(:,3), 'linewidth', 2);


xlabel('X Location (km)');
ylabel('Y Location (km)');
zlabel('Z Location (km)');
title('Inertial Frame Earth Moving');
legend('Earth Position', 'Satellite', 'location', 'best');


%Plotting center of mass as a function of time
figure();
subplot(3,1,1);
plot(TOUT4, YOUT4(:,7), 'linewidth', 2);

ylabel('X Position (km)');

subplot(3,1,2);
plot(TOUT4, YOUT4(:,7), 'linewidth', 2);

ylabel('Y Position (km)');

subplot(3,1,3);
plot(TOUT4, YOUT4(:,7), 'linewidth', 2);

ylabel('Z Position (km)');
xlabel('Time (s)');
sgtitle('Position of Center of Mass over Time');

%Plotting center of mass as a function of time
figure();
subplot(3,1,1);
plot(TOUT4, YOUT4(:,10), 'linewidth', 2);

ylabel('X Velocity (km/s)');

subplot(3,1,2);
plot(TOUT4, YOUT4(:,11), 'linewidth', 2);

ylabel('Y Velocity (km/s)');

subplot(3,1,3);
plot(TOUT4, YOUT4(:,12), 'linewidth', 2);

ylabel('Z Velocity (km/s)');
xlabel('Time (s)');
sgtitle('Velocity of Center of Mass over Time');


%% Functions
function outVec = EOM(t, state, mu)
    %Two body problem EOM
    %State is [x;y;z;vx;vy;vz]
    %t is time
    %mu is gravitational constant
    
    r = state(1:3);
    rDot = state(4:end);
    
    dr = rDot;
    rDotDot = -1*mu*r ./ (norm(r))^3;
    
    outVec = [dr; rDotDot];
end

function outVec = EOM2(t, state, mu)
    %Two body problem EOM with earth and spacecraft
    %State is [xs;ys;zs;vxs;vys;vzs;xe;ye;ze;vxe;vye;vze]
    %e is the earth, s is the spacecraft
    %t is time
    %mu is gravitational constant
    
    %Get state variables
    rs = state(1:3);
    re = state(7:9);
    rDots = state(4:6);
    rDote = state(10:end);
    
    %Get r position, spacecraft relative to earth
    r = rs - re;
    
    %Define rate of change of r for both spacecraft and earth
    drs = rDots;
    dre = rDote;
    
    %Calculate r double dot for the space craft
    rDotDot = -1*mu*r ./ (norm(r))^3;
    
    outVec = [drs; rDotDot; dre; [0;0;0]];
end


