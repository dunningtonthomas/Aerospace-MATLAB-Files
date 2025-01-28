%% Clean up
close all; clear; clc;

%% User Defined Functions
%Call calculate
[add, product] = calculate(2,6,10);

%Output to command window
disp(add);
disp(product);

%Ignore outputs
[add2, ~] = calculate(2,141,15);
[~, product2] = calculate(2,141,15);

%% Function Handles
% Use the @
%All of the inputs were a part of the function handle
calculate_handle = @calculate; %Creates function handle of calculate

[add3, product3] = calculate_handle(19,24,12);

%Specify default arguments
calculate_handle2 = @(a)calculate(a,5,5);

[add4, product4] = calculate_handle2(8);

%% Plotting
x = linspace(0, 2*pi, 250);
y1 = 5*sin(x); %Computes the sin() of every element in the x vector
y2 = 5*cos(x);

%Plot
figure();
plot(x, y1, 'linewidth', 2, 'color', 'r', 'linestyle', '--');
hold on;
grid on;
plot(x, y2, 'linewidth', 2, 'color', 'b');

%3D plot
figure();
plot3(mat(:,1), mat(:,2), mat(:,3));
hold on
plot(x,y1);



%Add labels
xlabel('x');
ylabel('Trig Functions of x');
title('Sine and Cosine of x');
legend('Sine of x', 'Cosine of x', 'location', 'best');

%% Recitation assignemnt

%Variables for height, length and breadth
h = 10;
l = 5;
b = 5;

%Call calculateAreaVolume(l,b,h) functions
[area,volume] = calculateAreaVolume(l,b,h);
disp(area);
disp(volume);

%%Functiom to calculate Area and Volume of Cuboid

function [area,volume] = calculateAreaVolume(l,b,h)
% Area
area = l*b+b*h+h*l;
%volume
volume = l*b*h;
 
end

























