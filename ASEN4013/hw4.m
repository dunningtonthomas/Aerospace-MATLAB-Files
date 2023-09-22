%% Clean up
close all; clear; clc;

%% Problem 3.12
M1 = 3.5;
theta = 15*pi/180;
T1 = -56.50 + 273.15;
P1 = 0.5529 * 10^4;
rho1 = 0.08891;

%Oblique shock jump
beta = BTMeq(theta, M1);

%Total Properties before
[p0op,t0ot,rho0orho] = isentropic(M1);
Tt1 = t0ot * T1;
Pt1 = p0op * P1;


%Total properties after
Mn1 = M1*sin(beta);

[ M2n,p2op1,rho2orho1,t2ot1,deltasoR,p02op01 ] = shock_calc( Mn1 );

M2 = M2n / sin(beta - theta);
P2 = p2op1 * P1;
rho2 =rho2orho1 * rho1;
T2 = t2ot1 * T1;


%Total Properties After
[p0op,t0ot,rho0orho] = isentropic(M2);
Tt2 = t0ot * T2;
Pt2 = p0op * P2;



%Determine when the shock will detach
Mvals = linspace(1.7,1.6,1000);

for i = 1:length(Mvals)
    
    beta = BTMeq(theta, Mvals(i));
    
    if(abs(beta) <= 1e-12)
       firstBreak = Mvals(i);
       break
    end
    
end


%% Problem 3.33
ToTstar = 0.692339;
[Mach] = TOverTStar(ToTstar);














