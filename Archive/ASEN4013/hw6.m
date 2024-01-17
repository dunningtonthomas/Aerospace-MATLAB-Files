%% Clean up
close all; clear; clc;


%% Problem 11.13
M0_3 = 3;
M0 = 2;
g = 1.4;

%A star
Arat_3 = Astar(M0_3,g);
Arat_2 = Astar(M0,g);

%Shock
[M2n,p2op1,rho2orho1,t2ot1,deltasoR,pRat3] = shock_calc(M0_3);
[M2n,p2op1,rho2orho1,t2ot1,deltasoR,pRat2] = shock_calc(M0);

A0At = Arat_3 * pRat3;

AtAstar = 1/A0At * Arat_2;
[Msup, Msub] = AoverAstar(g,AtAstar);

[M2n,p2op1,rho2orho1,t2ot1,deltasoR,ptRatStarted] = shock_calc(Msup);


%% Problem 11.28
gi = 1.33;
ge = 1.3;
Mi = 0.3;
CD = 1.5;
TteTti = 2;

phi = gi*Mi^2*(1 + ((gi-1)/2)*Mi^2) / (ge * (1 + gi*Mi^2*(1-CD/2))^2) * TteTti;
Me = sqrt(2*phi / (1 - 2*ge*phi + sqrt(1-2*(ge+1)*phi)));
pepi = (1 + gi*Mi^2 * (1 - CD/2)) / (1 + ge*Me^2);

ptepti = (1 + ((ge-1)/2)*Me^2)^(ge/(ge-1)) / (1 + ((gi-1)/2)*Mi^2)^(gi/(gi-1)) * pepi;






