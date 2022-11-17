

clear all;
close all;


recuv_tempest;

Va_trim = 21;
h_trim = 1800;

wind_inertial = [0;0;0];

trim_definition = [Va_trim; h_trim];


%%% Use full minimization to determine trim
[trim_variables, fval] = CalculateTrimVariables(trim_definition, aircraft_parameters);
[trim_state, trim_input]= TrimStateAndInput(trim_variables, trim_definition);
[Alon, Blon, Alat, Blat] = AircraftLinearModel(trim_definition, trim_variables, aircraft_parameters);

%Root locus for determining the k value
rlocus(ss(Alat, Blat(:,2), [0 0 -1 0 0 0], 0));
kr = 7.5;

%Determine the new state space 
AnewLat = Alat - Blat(:,2)*[0 0 -kr 0 0 0];

%Finding the eigenvalues to see how it affects the mode
[eig, eigVal] = eig(Alat);

[eigAfter, eigValAfter] = eig(AnewLat);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Helper code for Problem 3. Look inside the AircraftEOMControl function
% for hints on how to set up controllers for Problem 2 and Problem 4.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Transfer function from elevator to pitch angle
[num_elev2pitch, den_elev2pitch] = ss2tf(Alon(1:4,1:4), Blon(1:4,1), [0 0 0 1],0);

%%% Controller
kq = 1; %NOT REASONABLE VALUES
kth = 1; %NOT REASONABLE VALUES
num_c = [kq kth];
den_c = 1;

%%% Closed loop transfer function
pitch_cl = feedback(tf(conv(num_c, num_elev2pitch), conv(den_c, den_elev2pitch)),1);
[num_cl, den_cl] = tfdata(pitch_cl,'v');

%%% Poles of the closed loop (linear) system. Now do the same with the
%%% state stpace model.
roots(den_cl);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Full sim in ode45
aircraft_state0 = trim_state;
control_input0 = trim_input;

tfinal = 200;
TSPAN = [0 tfinal];
[TOUT2,YOUT2] = ode45(@(t,y) AircraftEOMControl(t,y,control_input0,wind_inertial,aircraft_parameters),TSPAN,aircraft_state0,[]);


for i=1:length(TOUT2)
    UOUT2(i,:) = control_input0';
end

PlotAircraftSim(TOUT2,YOUT2,UOUT2,wind_inertial,'b')



