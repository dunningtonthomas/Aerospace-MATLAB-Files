%% Question 1
clear; close all; clc;

%initialize input vector and call function
v = [50 100];
func1(v)

function func1(v)
g = 9.81;
theta = linspace(0,pi/2,50);

%calculate the two output vectors using the 2 different columns in the
%input vector
R1 = (v(1)^2/g)*sin(2*theta);
R2 = (v(2)^2/g)*sin(2*theta);

%plot the data with specified style
figure();
plot(theta,R1,'-b',theta,R2,'--r');
title("Cannon Range");
ylabel("Range [meters]");
xlabel("Cannon angle [radians]");
legend("v_1 = 50 m/s","v_2 = 100 m/s");
grid on;
end

%% Question 2
clear; close all; clc;

%call function with the file name grades.csv
% func2("grades.csv");

function func2(filename)

%read the the filen into the table grades
grades = readtable(filename);

%allocate memory for the grade vector
grade = zeros(height(grades));

disp("Students with a total grade of less than 70:")
for i = 1:height(grades)
    %calculate total grade for each student
    grade(i) = 0.3*grades.Var2(i) + 0.2*grades.Var3(i) + 0.5*grades.Var4(i);
    if grade(i) < 70
        %if the students total grade is less than 70, display their name to
        %the console
        disp(grades.Var1(i));
    end
end
end
%% Question 3
clear; close all; clc;

%initialize all inputs
t = 0:0.1:5;
theta = pi/4;
v0 = 50;
g = 9.81;

%call func3 with those inputs
[x, y, M2] = func3(v0, theta, g, t);

function [x, y, Mtransformed] = func3(v0, theta, g, t)
%calculate x and y postions based on time
x = v0*cos(theta)*t;
y = v0*sin(theta)*t - 0.5*g*t.^2;

%place both vectors in one matrix
XY = [x;y];
M = [2 0;0 1];
%use M to modify XY and store in Mtransormed
Mtransformed = [XY(1,:)*2 ; XY(2,:)];

%plot Mtransformed with respect to t with specified style
figure();
plot(t,Mtransformed(1,:),'go',t,Mtransformed(2,:),'ms');
title("Modified Trajectory");
ylabel("postion [y]");
xlabel("time [s]");
legend("x(modified)","y(modified)");
grid on;
end

%display the last column of Mtransformed (when t = 5)
disp(num2str(M2(:,length(t))));