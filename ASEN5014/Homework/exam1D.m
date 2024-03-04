%% Clean
close all; clear; clc;


%% Problem 1 1
A = [0,1,0,0;-2,0,1,0;-3,0,0,1;-4,0,0,0];
B = [0;0;5;6];
C = [1,0,0,0];
D = 0;

sys = ss(A,B,C,D);
tf1 = tf(sys);


%% Problem 1 2
A = [0,0,1,0;0,0,0,1; -1,0,-2,-2;-4,0,-5,-6];
B = [0,0;0,0;1,0;1,3];
C = [1,3,0,0;0,0,1,5];
D = [0,0;0,0];
T = [1,0,1,0;0,1,2,1;1,0,0,2;0,1,1,1];
Tinv = inv(T);

sys1 = ss(A,B,C,D);


At = Tinv*A*T;
Bt = Tinv*B;
Ct = C*T;
Dt = D;

sys2 = ss(At,Bt,Ct,Dt);

tf1 = tf(sys1);
tf2 = tf(sys2);

%% Problem 2
A = [1,0,1;2,7,2;-1,2,-3;1,2,3;5,5,-1];
G = A'*A;
z = [1;3;5;7;9];
leftNull = null(A');

y1 = leftNull(:,1);
y2 = leftNull(:,2);


comp1 = dot(z,y1)/(norm(y1)^2);
comp2 = dot(z,y2)/(norm(y2)^2);


n1f = comp1*y1;
n2f = comp2*y2;

u = n1f + n2f;

ortho1 = (z-u)'*y1;
ortho2 = (z-u)'*y2;


%% Problem 3
A = [1,0,0;2,3,1;3,4,-1;1,1,1];
G = A'*A;


%% Problem 5 1
y1 = [1;2;3];
y2 = [4;6;7];
y3 = [-3;-4;-3];

A = [y1,y2,y3];

v1 = y1;
v2 = y2 - (v1'*y2)/(v1'*v1)*v1;
v3 = y3 - (v1'*y3/(v1'*v1)*v1 + v2'*y3/(v2'*v2)*v2);

v1hat = v1 / norm(v1);
v2hat = v2 / norm(v2);
v3hat = v3 / norm(v3);


y = A(:,1);
A = A(:,2:end);
w = [A, y];


%% Problem 5 2

y1 = [1;9;7;3;12];
y2 = [2;0;0;3;3];
y3 = [2;0;0;8;4];

A = [y1,y2,y3];
G = A'*A;

v1 = y1;
v2 = y2 - (v1'*y2)/(v1'*v1)*v1;
v3 = y3 - (v1'*y3/(v1'*v1)*v1 + v2'*y3/(v2'*v2)*v2);

v1hat = v1 / norm(v1);
v2hat = v2 / norm(v2);
v3hat = v3 / norm(v3);


y = A(:,1);
A = A(:,2:end);
w = [A, y];


%% Problem 5 3

y1 = [1;5;1;2];
y2 = [2;10;2;4];
y3 = [-1;-2;0;4];
y4 = [0;3;1;6];
y5 = [-2;-7;-1;2];

A = [y1,y2,y3,y4,y5];
Ap = [y1, y3];
Gp = Ap'*Ap;
G = A'*A;

y1 = [1;5;1;2];
y2 = [-1;-2;0;4];
v1 = y1;
v2 = y2 - (v1'*y2)/(v1'*v1)*v1;

v1hat = v1 / norm(v1);
v2hat = v2 / norm(v2);



y = A(:,1);
A = A(:,2:end);
w = [A, y];





