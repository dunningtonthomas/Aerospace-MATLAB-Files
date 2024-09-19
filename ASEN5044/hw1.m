%% Clean
close all; clear; clc;

%% Problem 2
A = [0, 1, 0, 0; -2, 0, 1, 0; 0, 0, 0, 1; 1,0, -2, 0];
B = [0,0; -1, 0; 0, 0; 1, 1];
C = [1,0,0,0; 0,0,1,0];
D = [0,0;0,0];
T = [1,0,-1,0; 0,1,0,-1; 1,0,1,0; 0,1,0,1];

Atild = T*A*inv(T);
Btild = T*B;
Ctild = C*inv(T);



%% Problem 3
Ix = 500;
Iy = 750; 
Iz = 1000;
p0 = 20;
dt = 0.1;
A = [0,0,0; 0,0, p0*(Ix-Iz)/Iy; 0, p0*(Iy-Ix)/Iz, 0];

stm = expm(A*dt);

x0 = [0; 0.1; 0];

times = 0:0.01:5;
xfinal = zeros(length(times), 3);
for i = 1:length(times)
    dt = times(i);
    eAt = (expm(A.*dt));
    xfinal(i,:) = (eAt*x0)';
end



% Plot
figure();
subplot(3,1,1);
plot(times, xfinal(:,1), 'LineWidth', 2, 'Color', 'b');
ylabel('del p (rad/s)')
grid on;

subplot(3,1,2);
plot(times, xfinal(:,2), 'LineWidth', 2, 'Color', 'g');
ylabel('del q (rad/s)')
grid on;

subplot(3,1,3);
plot(times, xfinal(:,3), 'LineWidth', 2, 'Color', 'r');

grid on;
xlabel('Time (s)');
ylabel('del r (rad/s)')

sgtitle('Spacecraft Dynamics Simulation')




