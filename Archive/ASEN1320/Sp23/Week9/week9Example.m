% Week 9 (week of 3/13)

%Today:
%  welcome to matlab
%  conditional statements (if, if-else, nested if-else, switch)
%  basic vector-matrix operations


%optional:
%  user-defined functions with understanding of scope concept
%  handle multiple source files
%  make simple plots

%% Welcome to MATLAB!

% create a new script by pressing new + button in top left and selecting script
      % Matlab scripts end in .m instead of .cpp !
      % Point out file directory, editor, command window, workspace! 
      % they should know these from lecture

% This is how you comment. (show comment buttons in editor)


%% clearing options 
  clc;          % to clear command window
  clear all;    % to clear workspace
  close all;    % to close open windows (like figures or plots)

%% Create some variables

    a = 1;   %double
    b = 'b'; %char
    c = "String Variable"; %string
        % no need to specify type!
        % run code and show how they show up in workspace
        % run code with and without semicolons
        % show how you can type them into command window and do math there
%% Variable operations
%+/-/divide/multiply
x = 10;
y = 3;
disp(x+y)
disp(x-y)
disp(x/y)
disp(x*y)

%Trig
angle = 30; %[degrees]


%cos, sin, asin, acos, tan, atan all take in radians. for degrees use
%cosd,sind,acosd,asind, tand, atand
%remove semi-colon to show the results of these operations

cosAngleradians =  cos(angle*pi/180); %convert the angle to radians before use
cosAngledegrees = cosd(angle);


%% conditional statements: if, elseif, else
    
    % operators and &&, or ||, negate ~ 
    % same as C++ but negate is now ~ instead of !

    % true && false; %    return false
    % true || false; %    return true
    
    %   if statements
    if (true)
        disp("this will be printed")
    end

    if(~true)
        disp("this will not print")
    end

    x=7; y=4;
    if (x == y)
        disp("this prints if x=y")
    elseif (x>y)
        disp("this prints is x>y")
    else
        disp("print this otherwise")
    end

%% printing w variables
    % fprintf
    fprintf('this is an fprintf statement\n')
    fprintf('to print integers like %d. use this\n', x);
    fprintf('to print decimal numbers like %f, use this\n', 3.14)
    fprintf('to limit the number of decimals like %.2f use this\n', 3.141592654)
    fprintf('to print multiple things like %d and %.2f, use this\n', 8, 3.1415)

    %https://www.mathworks.com/help/matlab/matlab_prog/formatting-strings.html


%% Vectors! (like arrays in C++!)
    vec1 = [1,3,5,7,9]; %row vector
    vec2 = [1;3;5;7;9]; %column vector 
    disp(vec1)
        % show them in the workspace, row vs column
        %s how transpose with '

         %more ways to define vectors
    vec3 = 1:10; %from 1 to 10 in increments of 1
    vec4 = 1:0.5:10; % from 1 to 10 in increments of 0.5

        %combining vectors - concatenate
    concat = [vec3, vec4];
        % sizes must align! 
        % for example these both have 1 row and we are combining them into the same row.
        % we could NOT put them on top of each other bc of different # of columns

        %another method...
    vec5 = linspace(1,10); %100 elements between 1 and 10
    vec6 = linspace(1,10,20); %(start,end,numelements)
                          %20 elements between 1 and 10

        % element-wise arithmetic
    vec7 = [2,4,6,8,10];
    vec8 = vec1 + vec7;
    disp("Adding vectors element-wise")
    disp(vec8);
    vec9 = vec1 .* vec7;
    disp("Multiplying vectors element-wise")
    disp(vec9);

            %*** use : when you know the increment SIZE
            %*** use linspace when you know how MANY increments you want

            % we can also make 2D vectors -> MATRICES
    vec2D = [1,2;3,4]; %print to command window and show 2x2 arrangement

%% indexing! (Starts at 1 in MATLAB!!)
    x = vec1(1); %show in command window

    %index multiple at a time...
    y = vec1(2:4); %show in command window

    %change the vector?
    vec1(1:3) = [10,9,8];
    
    %indexing into a matrix:
    z = vec2D(1,2); %1st row, 2nd column
        % emphasize: IF YOUR VECTOR (MATRIX) HAS MULTIPLE DIMENSIONS, THEN YOU 
        % MUST ALWAYS USE MULTIPLE INDICES
        % (ROW,COLUMN) ALWAYS
    
%% Vector Operations
%Logical Vectors
logicalVec1 = vec1 <= 8; %Will create a vector of the same size. a 1 represents that index is <= 8 and 0 represents index is >8
%But what are the values data at the indexes?
%remove semi-colon to show the output of the below.
trueConditionVec = vec1(logicalVec1);


%max, min, size, length
[maxVec2,ind2max] = max(vec2);
[minVec2,ind2min] = min(vec2);
lengthVec2 = length(vec2);
sizevec2D = size(vec2D);

%Transpose Vectors
vec2Transpose = vec2';
disp("Tranposing Vectors")
disp(vec2Transpose)
disp(vec2)
