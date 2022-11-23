close all; clear variables; clc; 

% initial parameters of sat1 and sat2 declaration 
y0sat1 = [1986.2; 6388.2; -1237.2; -4.93; 0.40; -5.83]; 
y0sat2 = [6480.8; 1108.2; -2145.5; -0.29; 7.07; 2.75]; 

% creating function handle of OrbitEOM
f = @OrbitEOM;

% declaring tspan
tspan = 0:60:86400; 



% part 1.1      
options = odeset('RelTol',1e-12, 'AbsTol',1e-12); 

% Using ode45 to integrate function OrbitEOM for both sat1 and sat2
[t1, s1] = ode45(f, tspan, y0sat1, options); 
 
[t2, s2] = ode45(f, tspan, y0sat2, options); 


% part 1.2
Sat1Position =  [s1(:,1),s1(:,2),s1(:,3)];      % creates array for x, y, z positions of sat1
Sat2Position = [s2(:,1),s2(:,2),s2(:,3)];       % creates array for x, y, z positions of sat2

% stores arrrays in files 
writematrix(Sat1Position,"Sat1Position.csv");   
writematrix(Sat2Position, "Sat2Postion.csv"); 


% part 1.3
x1 = Sat1Position(:, 1);
y1 = Sat1Position(:,2); 
z1 = Sat1Position(:,3); 
x2 = Sat2Position(:,1);
y2 = Sat2Position(:,2); 
z2 = Sat2Position(:,3); 

plot3(x1,y1,z1,x2,y2,z2);           % plots a 3D figure of the ISS's and Hubbles's orbits around earth

savefig('part1.fig');
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
legend('ISS','Hubble'); 
title('LEOs of the ISS and Hubble Space Telescope')
