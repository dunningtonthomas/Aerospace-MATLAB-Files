%% Clean
close all; clear; clc;


%% Problem 1
A = [1,0;0,2];


%% Problem 2
A = [1,1,1; 0,1,1;1,0,0];

[vec, vals] = eig(A);


syms a b c
B = [a;b;c];
B = [1;0;0];

C = [B A*B A^2*B];


B = [1;0;1];
K = [-2,3,5];

closedA = A - B*K;

[vec, vals] = eig(closedA);


%% Problem 3
A = [-5,3,5,2,-4,-1; 0.7,-1.55,0.65,8.6,-6.1,0.1; -0.7,0.55, -1.65, -0.6, 0.1, -0.1;...
    1.70,-1.05,-4.85,2.6,-1.1,1.1; 0, 0.5, 0.5, 4, -5, 0; -1.8, 1.2, 6.4, -4.4, 0.4, -3.4];

B = [1;1;1;2;2;0];
C = [1,2,0,0,0,0];
D = 0;

[T, vals] = eig(A);

diag = inv(T)*A*T;
Btild = inv(T)*B;
Ctild = C*T;



%% Problem 4
A = [0,2,1; -1,0,1;3,-2,1;0,4,1;1,2,1];

LN = null(A');
y = LN(:,1);

W = [A y];


A = [1,1,1,1,; 2,4,6,3; 0,2,4,1; 1,-1,-3,0];
y = [5;25;15;-10];

Aug = [A y];
Ared = A(1:2, :);
yred = y(1:2);

xln = Ared'*inv(Ared*Ared')*yred;

RN = null(A);

x1 = xln + RN(:,1);
x2 = xln + RN(:,2);






