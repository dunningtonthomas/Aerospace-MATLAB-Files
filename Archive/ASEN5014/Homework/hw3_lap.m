%% Clean up
close all; clear; clc;

%% Problem 1
B = [1, 1, 1; 1, -1, 0; 1, 1, 0];
R = inv(B'*B)*B';

B = [4,2,1;2,6,3;1,3,5];
R = inv(B'*B)*B';
R = inv(B);

r1 = R(1,:);
r2 = R(2,:);
r3 = R(3,:);

x = [6;3;1];

b1 = dot(r1, x);
b2 = dot(r2, x);
b3 = dot(r3, x);


test = b1*B(:,1) + b2*B(:,2) + b3*B(:,3);


%% Problem 2
B = [1,1,0,2;2,0,2,2;1,0,3,1];
G = B'*B;

y1 = [1;2;1];
y2 = [1;0;0];
y3 = [0;2;3];

v1 = [1;2;1];
v2 = y2 - (dot(v1,y2) / dot(v1, v1) * v1);
temp = dot(v2, y3) / dot(v2, v2) * v2;
v3 = y3 - (7/6 * v1 + temp);

v1N = v1 ./ norm(v1);
v2N = v2 ./ norm(v2);
v3N = v3 ./ norm(v3);


%% Problem 3
y1 = [1;2;2;1];
y2 = [1;0;1;0];
v1 = y1;
y = [1;2;3;4];

v2 = y2 - dot(v1,y2)/dot(v1,v1) * v1;

v1N = v1 / norm(v1);
v2N = v2 / norm(v2);

b1 = dot(y, v1N);
b2 = dot(y, v2N);

yp = b1*v1N + b2*v2N;


orthoTest = dot(yp - y, y2);




%% Problem 4
y = [2;5;3];
c = [1;2;-1;];
yp = dot(y,c)/norm(c)^2 * c;

cN = c / norm(c);

Ap = eye(3) - cN*cN';
vpar = Ap * y;



