%% Clean Up
clear; close all; clc;

%This a comment

%% This is a new section
x = 5;
string = "Word";

%% Trig functions
angle = 30; %degrees

cosAngle = cosd(30);
cosAngleRad = cos(angle * pi / 180);

%asin, acos, tan, atan --> radians
%cosd, sind, acosd, asind, tand,

%% Conditional statements
% && || ~ (negate)

if(true)
    disp("This will be printed");
    fprintf("This will be printed\n");
end

if(~true)
    disp("This will not be printed");
    fprintf("This will not be printed\n");
end

x = 7;
y = 4;

if(x == y)
    disp("this print if x = y");
elseif(x > y)
    disp("this prints if x > y");
else
    disp("Print this otherwise");
end

%% Printing variables to the command window
% fprintf
x = 40;
fprintf("To print integers like %d and like %d, use this\n", x, x);
fprintf("to print floating point like %f, use this\n", 3.145);
fprintf("to print floating point like %.2f, use this\n", 3.145);


%% Vectors 
vec1 = [1,3,5,7,9]; %Row vector
vec2 = [1;3;5;7;9]; %Column vector

%Transpose 
vec3 = vec1';
vec4 = vec2';

%Matrices
mat = [1,2,3; 4,5,6; 7,8,9];
matTranspose = mat';

%Combine vectors
vecCombine = [vec2, vec3];


%Defining vectors
vec5 = 1:0.25:10;
vec6 = linspace(0,10,1000);

%Element wise arithmetic
vecAdd = vec4 + vec1; %Sizes must be the same

%Vector multiplication
vecMultiply = vec4 .* vec1;
vecDivide = vec4 ./ vec1;

%Index into vectors
%indexing starts at 1 

%Indexing into matrices
firstRow = mat(1,:);
firstColumn = mat(:,1);

%Logical vectors
xVec = linspace(1,10,100);
logVec = xVec <= 2 & xVec >= 1.5;
xVecLessThan5 = xVec(logVec);

%max, min, size, length
[maxValue, maxIndex] = max(xVec);
[minValue, minIndex] = min(xVec);
lengthXVec = length(xVec);
sizeMat = size(mat);

mat2 = [1,2;3,4;5,6];
sizeMat2 = size(mat2);


















