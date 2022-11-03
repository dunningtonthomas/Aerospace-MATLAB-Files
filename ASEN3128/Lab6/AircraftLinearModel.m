function [Alon, Blon, Alat, Blat] = AircraftLinearModel(trim_definition, trim_variables, aircraft_parameters)
%
% STUDENT COMPLETE


u0 = trim_definition(1);
h0 = trim_definition(2);

alpha0 = trim_variables(1);
de0 = trim_variables(2);
dt0 = trim_variables(3);

theta0 = alpha0;

ap = aircraft_parameters;
rho = stdatmo(h0);



%%%%%%%%%%%%%%%%%%%%%%
%%% Longitudinal
%%%%%%%%%%%%%%%%%%%%%%

%%%% Trim values
CW0 = ap.W/((1/2)*rho*u0^2*ap.S);
CL0 = CW0*cos(theta0);
CD0 = ap.CDmin + ap.K*(CL0-ap.CLmin)^2;
CT0 = CD0 + CW0*sin(theta0);


%%%% Nondimensional stabiulity derivatives in body coordinates

%%%%% This is provided since we never discussed propulsion - Prof. Frew
dTdu = dt0*ap.Cprop*ap.Sprop*(ap.kmotor-2*u0+dt0*(-2*ap.kmotor+2*u0));
CXu = dTdu/(.5*rho*u0*ap.S)-2*CT0;

CDu = 0;%CDM*Ma;    % Compressibility only.  Ignore aeroelasticity and other effects (dynamic pressure and thrust).
CLu = 0;%CLM*Ma;
Cmu = 0;%CmM*Ma;


%Complete the below
CZu = 0;

CZalpha = -CD0 - ap.CLalpha;

CXalpha = CL0*(1-2*ap.K*ap.CLalpha);

CZalphadot = -ap.CLalphadot;

CZq = -ap.CLq;


% Longitudinal dimensional stability derivatives (from Etkin and Reid)
Xu = rho*u0*ap.S*CW0*sin(theta0) + (1/2)*rho*u0*ap.S*CXu;
Zu = -rho*u0*ap.S*CW0*cos(theta0) + (1/2)*rho*u0*ap.S*CZu;
Mu = (1/2)*rho*u0*ap.S*ap.c*Cmu;


Xw = (1/2)*rho*u0*ap.S*CXalpha;
Zw = (1/2)*rho*u0*ap.S*CZalpha;
Mw = (1/2)*rho*u0*ap.S*ap.c*ap.Cmalpha;

Xq = 0;
Zq = (1/4)*rho*u0*ap.c*ap.S*CZq;
Mq = (1/4)*rho*u0*ap.c^2*ap.S*ap.Cmq;

Xwdot = 0;
Zwdot = (1/4)*rho*ap.c*ap.S*CZalphadot;
Mwdot = (1/4)*rho*ap.c^2*ap.S*ap.Cmalphadot;


% Matrices
Alon = [Xu/ap.m, Xw/ap.m, 0, -ap.g*cos(theta0), 0, 0;
    Zu/(ap.m-Zwdot), Zw/(ap.m-Zwdot), (Zq+ap.m*u0)/(ap.m-Zwdot), -ap.m*ap.g*sin(theta0)/(ap.m-Zwdot), 0, 0;
    (1/ap.Iy)*(Mu + (Mwdot*Zu)/(ap.m-Zwdot)), (1/ap.Iy)*(Mw + (Mwdot*Zu)/(ap.m-Zwdot)), (1/ap.Iy)*(Mq + (Mwdot*(Zq+ap.m*u0))/(ap.m-Zwdot)), (-Mwdot*ap.m*ap.g*sin(theta0))/(ap.Iy*(ap.m-Zwdot)), 0, 0;
    0, 0, 1, 0, 0, 0;
    1, 0, 0, 0, 0, 0;
    0, 1, 0, -u0, 0, 0];

Blon = zeros(6,2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Lateral
%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lateral-directional dimensional stability derivatives
Yv = (1/2)*rho*u0*ap.S*ap.CYbeta;
Yp = (1/4)*rho*u0*ap.b*ap.S*ap.CYp;
Yr = (1/4)*rho*u0*ap.b*ap.S*ap.CYr;

Lv = (1/2)*rho*u0*ap.b*ap.S*ap.Clbeta;
Lp = (1/4)*rho*u0*ap.b^2*ap.S*ap.Clp;
Lr = (1/4)*rho*u0*ap.b^2*ap.S*ap.Clr;

Nv = (1/2)*rho*u0*ap.b*ap.S*ap.Cnbeta;
Np = (1/4)*rho*u0*ap.b^2*ap.S*ap.Cnp;
Nr = (1/4)*rho*u0*ap.b^2*ap.S*ap.Cnr;

G = ap.Ix*ap.Iz-ap.Ixz^2;

G3=ap.Iz/G;
G4=ap.Ixz/G;
G8=ap.Ix/G;


Alat = [Yv/ap.m, Yp/ap.m, (Yr/ap.m - u0), ap.g*cos(theta0),0,0;
    G3*Lv + G4*Nv, G3*Lp + G4*Np, G3*Lr + G4*Nr, 0, 0, 0;
    G4*Lv + G8*Nv, G4*Lp + G8*Np, G4*Lr + G8*Nr, 0, 0, 0;
    0, 1, tan(theta0), 0, 0, 0;
    0, 0, sec(theta0), 0, 0, 0;
    1, 0, 0, 0, u0*cos(theta0), 0];




Blat = zeros(6,2);


