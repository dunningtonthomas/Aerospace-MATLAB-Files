

clear all;
close all;


recuv_tempest;

Va_trim = 22;
h_trim = 2438.5;

wind_inertial = [0;0;0];

trim_definition = [Va_trim; h_trim];


%%% Determine trim
[trim_variables, fval] = CalculateTrimVariables(trim_definition, aircraft_parameters);
[trim_state, trim_input]= TrimStateAndInput(trim_variables, trim_definition);


%%% Linear matrices
[Alon, Blon, Alat, Blat] = AircraftLinearModel(trim_definition, trim_variables, aircraft_parameters);


%%%%% Set initial condition
% STUDENTS COMPLETE

%Getting the eigenvectors for longitudinal
[eigenLat, eigVals] = eig(Alat); %5 and 6 columns are the phugoid eigens

dutchEigen = eigenLat(:,4);
dutchEigen = dutchEigen / (dutchEigen(4));
dutchEigen = dutchEigen * (2*pi/180); %Scaling so initial pitch is 2 degrees
dutchEigenReal = real(dutchEigen); %Order [v,p,r,phi,psi,y]
addInitialDutch = [0; dutchEigenReal(6); 0; dutchEigenReal(4); 0; dutchEigenReal(5); 0; dutchEigenReal(1); 0; dutchEigenReal(2); 0; dutchEigenReal(3)];

%Adding the phugoid eigenvector to the initial trim state to get the
%initial condition
aircraft_state0 = trim_state + addInitialDutch;
control_input0 = trim_input;

%%% Full NONLINEAR sim in ode45
tfinal = 10;
TSPAN = [0 tfinal];
[TOUT1,YOUT1] = ode45(@(t,y) AircraftEOM(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);


for i=1:length(TOUT1)
    UOUT1(i,:) = control_input0';
end

PlotAircraftSim(TOUT1,YOUT1,UOUT1,'b')


%%% Linear simulation
% STUDENTS COMPLETE
%Use ss to create the linear system
A = Alat;
B = Blat;
C = eye(6);
D = Blat; %This is just zeros

%Creating the linear system
%% Phugoid mode
system = ss(A,B,C,D);
[deltaX,TOUT2,~] = initial(system, dutchEigenReal,tfinal);

%Adding the delta x to xtrim
YOUT2 = zeros(length(deltaX(:,1)), 12);
for i = 1:length(deltaX(:,1))
     deltaX12 = [0, deltaX(i,6), 0, deltaX(i,4), 0, deltaX(i,5), 0, deltaX(i,1), 0, deltaX(i,2), 0, deltaX(i,3)];
     YOUT2(i,:) = deltaX12 + trim_state'; 
     YOUT2(i,1) = TOUT2(i) * Va_trim;
end


%Getting the control
for i=1:length(TOUT2)
    UOUT2(i,:) = control_input0';
end

PlotAircraftSim(TOUT2,YOUT2,UOUT2,'r')


