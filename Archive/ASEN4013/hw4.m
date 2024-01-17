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
[Mach] = TOverTStar(ToTstar, 1.4);

%Calculate Pt over Pt*
g = 1.4;
M = 0.3;
PtOPtStar = (g + 1) / (1 + g*M^2) * ((2/(g+1)) * (1 + (g-1)/2*M^2))^(g/(g-1));

%After the heating
M = Mach;
PtOPtStar2 = (g + 1) / (1 + g*M^2) * ((2/(g+1)) * (1 + (g-1)/2*M^2))^(g/(g-1));

%Total temperature after the heating
Pt2 = PtOPtStar2* 1/PtOPtStar * 600;



% Different gas
g = 1.325;
cp = 1.171;
M = 0.3;
Tt2 = 500 / cp + 500;

Tt1oTt1Star = (2*(g + 1).*M.^2).*(1+(g-1)/2 .* M.^2) ./ (1 + g*M.^2).^2;
Tt2oTt2Star = Tt1oTt1Star * Tt2 / 500;

%Calculate the mach number
[Mach] = TOverTStar(Tt2oTt2Star, g);

%Calculate Pt over Pt*
M = 0.3;
PtOPtStar = (g + 1) / (1 + g*M^2) * ((2/(g+1)) * (1 + (g-1)/2*M^2))^(g/(g-1));

%After the heating
M = Mach;
PtOPtStar2 = (g + 1) / (1 + g*M^2) * ((2/(g+1)) * (1 + (g-1)/2*M^2))^(g/(g-1));

%Total temperature after the heating
Pt2 = PtOPtStar2* 1/PtOPtStar * 600;



%% Problem 5.9
M0 = 2.1;
g = 1.4;
cp = 1.004;
T0 = 220;
Tt4 = 1700;


%Calculate tauR which is the total temperature ratio
tr = 1 + (g-1)/2 * M0^2;
Tt0 = T0*tr;

%Burner to ambient enthalpy ratio
tlambda = Tt4 / T0;


%Optimal compressor pressure ratio
tcMax = sqrt(tlambda / tr);
tcMaxThrust = sqrt(tlambda) / tr;
piC = tcMax^(g/(g-1));

%Turbing temperature ratio
tt = 1 - tr / tlambda * (tcMax - 1);


%Speed of sound
R = cp - cp/g;
a0 = sqrt(g*R*1000*220);

%Specific thrust
F = a0*(sqrt(2/(g-1)*tlambda/tr/tcMax * (tr*tcMax*tt - 1)) - M0);

%Fuel consumption
f = cp*220 / 42800 * (tlambda - tr*tcMax);
s = f / F;
sHr = s * 3600;



