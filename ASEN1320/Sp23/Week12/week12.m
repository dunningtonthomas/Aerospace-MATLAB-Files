%% Clean up
close all; clear; clc;

%% Structs
student = struct('Name', 'Chris', 'Section', 113, 'Grade', 'A');

%Accessing fields
student.Name;
student.Section;
student.Grade;

%Second way to declare struct
clear all;
student.Name = "Chris";
student.Section = 113;
student.Grade = 'A';

%% Structure vector
student1 = struct('Name', 'Chris', 'Section', 113, 'Grade', 'A');
student2 = struct('Name', 'John Doe', 'Section', 105, 'Grade', 'B');

studentVector = [student1; student2];

%% Extra Stuff
%Function handle inside of the structure
coords.x = linspace(0,10,100);
coords.y = sin(coords.x);
coords.plotFunc = @(x,y)plot(x,y);

figure();
coords.plotFunc(coords.x, coords.y);

%% File I/O
data = readmatrix("data.txt");
dataTable = readtable("data.txt");
disp(dataTable.x)
disp(dataTable.y)


%% Writing to a file
fileId = fopen('coords.txt', 'w');

%Use fprintf
fprintf(fileId, '%s %10s\n', 'x', 'y');

%Write an array
x = [0, 10, 20, 30];
y = [0, 2, 5, 9];

A = [x;y];

fprintf(fileId, '%f %10f\n', A);

%Close the file
fclose(fileId);

%% Writing with csvwrite and writematrix
csvwrite('coords.csv', A);
writematrix(A, 'coords2.csv');

ImportedData = readmatrix('coords.csv');




