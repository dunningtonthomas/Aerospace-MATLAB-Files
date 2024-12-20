%% Clean
close all; clear; clc;

%% Problem 2
A1 = [0,1;-3,-4];
B1 = [0;1];
C1 = [2,1];
D1 = 0;

A2 = [0,1,0; 0,0,1; 3,1,-3];
B2 = [0;0;1];
C2 = [-2,1,1];
D2 = 0;

A3 = [0,1, 0;-3,-4, 0; 5, 4, 10];
B3 = [0;1;1];
C3 = [2,1,0];
D3 = 0;

m1 = ss(A1,B1,C1,D1);
m2 = ss(A2,B2,C2,D2);
m3 = ss(A3,B3,C3,D3);


%% Problem 3
y1 = [1;3;6;9;-1];
y2 = [2;3;2;3;2];
v1 = y1;

v2 = y2 - dot(v1,y2)/dot(v1,v1)*v1;

v1N = v1 / norm(v1);
v2N = v2 / norm(v2);


A = [y1,y2];


w = [1;2;3;4;5];
res = A' * w;

Ap = [A, w];






%% Problem 4
A = [1,2,1,1;1,3,4,2;3,8,9,5;4.5,12.5,15,8];
y = [10;17;44;69.5];
Ap = [A, y];

x0 = [1;1;2;1];

Aaug = [A, y];

Arr = rref(Aaug);
ArrNew = Arr(1:2, 1:(end-1));
ynew = Arr(1:2,end);

Anew = A(1:2,:);

xln = Anew'*inv(Anew*Anew')*y(1:2);
xNol = ArrNew'*inv(ArrNew*ArrNew')*ynew;

B = null(A);

xbest = x0 - xln;

Baug = [B, xbest];

nls = inv(B'*B)*B'*xbest;

xnls = B * nls;

xFinal = xln + xnls;


%% Next Part
xnPre = [0;0;1;1] - xln;
xnPreT = xnPre(3:4);
Bp = B(3:4, :);
Bpaug = [Bp, xnPreT];
sol = rref(Bpaug);
nullCoeff = sol(:,end);

xn = B * nullCoeff;

xf2 = xln + xn;


