%% Recitation 10
clear; close all; clc


%Declare variables
g = 9.81;                   %[m/s^2]
T1 = 1; T2 = 3; T3 = 5;     %[s]


%Function Handle 
f = @PendulumLength;

%Pendulum Lengths           %[m]
l1 = f(g,T1);
l2 = f(g,T2);
l3 = f(g,T3);


%----- Problem 2 -----%

[lmax,lmin] = MaxMin("PendulumData.txt",f,g);

%------------ASSUME THIS SECTION IS THE FILE FOR THE FUNCTION "PendulumLength" ------------%

function l = PendulumLength(g,T)

l = g*(T/(2*pi)).^2;

end 


function [xmax,xmin] = MaxMin(filename,f,g)
T = readmatrix(filename);

% for i = 1:length(T)
%     
%     L(i) = f(g,T(i));
%     
% end 

L = f(g,T);

xmax = max(L);
xmin = min(L);
end 
