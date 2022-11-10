%% Clean Up
clear; close all; clc;

%% Problem 1

x = linspace(-1,3,100);
y = zeros(length(x),1);

for i = 1:length(x)
   if(x(i) >= -1 && x(i) < 0)
       y(i) = (x(i)^2 + 1)/(x(i)^2 + x(i));
   elseif(x(i) >= 0 && x(i) < 2.718)
       y(i) = 15*log(x(i));
   else
       y(i) = 12.386 - x(i)^2;
   end
end

figure();
plot(x,y,'linewidth',2,'color', 'c');


%% Problem 2
times = [0 3.5];
y0 = 1;
a = 9.9;
b = 1.25;

funcHand = @(t,y)func2(t,y,a,b);

%Integrate with ode45
[YOUT, TOUT] = ode45(funcHand, times, y0);

%Saving to a .mat file
save('odestufff.mat', 'YOUT', 'TOUT');

%Plotting
figure();
plot(YOUT, TOUT, 'linewidth', 2);
grid on;


%Function
function dydt = func2(t,y,a,b)
    dydt = a*sin(y*t) - b*y;
end






