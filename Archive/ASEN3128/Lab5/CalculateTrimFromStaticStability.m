% Eric W. Frew and Zachary N. Sunberg
% ASEN 3128
% Created: 10/15/20
% STUDENTS COMPLETE THIS FUNCTION

function [alpha_trim, elevator_trim] = CalculateTrimFromStaticStability(trim_definition, aircraft_parameters)
%
% Inputs:	trim_definition         = [V0; h0]
%           aircraft_parameters     = structure with A/C parameters
%
%
% Outputs:	alpha_trim
%           elevator_trim
%
%
% Methodology: Uses linearized force and moment balance to estimate elevator and aoa for trim

ap = aircraft_parameters;
Va_trim = trim_definition(1);
h_trim= trim_definition(2);
rho_trim = stdatmo(h_trim);

%%% Students complete function below
%%% Determine lift coefficient needed for trim.

%Calculating the lift at trim
lift = aircraft_parameters.W; %Lift equals the weight

%Getting the air density from the standard atmosphere model
rho = stdatmo(h_trim);
planformArea = aircraft_parameters.S;

%Calculating CL at trim
CLtrim = lift / ((0.5)*rho*Va_trim^2*planformArea);

%Getting variables for calculating alpha and elevator deflection
delta = aircraft_parameters.CLalpha * aircraft_parameters.Cmde - aircraft_parameters.CLde*aircraft_parameters.Cmalpha;

alpha_trim = (aircraft_parameters.Cm0 * aircraft_parameters.CLde + aircraft_parameters.Cmde * CLtrim) / delta;
elevator_trim = -(aircraft_parameters.Cm0 * aircraft_parameters.CLalpha + aircraft_parameters.Cmalpha * CLtrim) / delta;


%%% Solve system of equations for angle of attack and elevator angle.
