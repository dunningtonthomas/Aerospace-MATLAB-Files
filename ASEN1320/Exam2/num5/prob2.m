clc;
clear;
close all;

t = [0,3.5];
y0 = 1;
a = 9.9;
b = 1.25;

f = @(t,y)func2(t,y,a,b);

[timeVector, Youtput] = ode45(f,t,y0);

% No idea how to write this matrix out as a mat file. Weve only written
% CSVs so heres a csv. The .mat thing does nothing
Matrix = [timeVector Youtput];
writematrix(Matrix, 'output2.csv');

myfile = fullfile(tempdir,'output2.mat');
matObj = matfile(myfile,'Writable',true);

plot(timeVector,Youtput, 'lineWidth', 2);

grid on
