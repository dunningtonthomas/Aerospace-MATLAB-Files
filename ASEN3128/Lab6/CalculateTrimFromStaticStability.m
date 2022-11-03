% Eric W. Frew
% ASEN 3128
% CalculateTrimFromStaticStability.m
% Created: 10/15/20

function [alpha_trim, elevator_trim] = CalculateTrimFromStaticStability(trim_definition, aircraft_parameters)

ap = aircraft_parameters;
Va_trim = trim_definition(1);
h_trim= trim_definition(2);
rho_trim = stdatmo(h_trim);


weight = ap.m*ap.g;

CLtrim = weight/(.5*rho_trim*Va_trim^2*ap.S);


b = [CLtrim-ap.CL0; -ap.Cm0];
A = [ap.CLalpha ap.CLde; ap.Cmalpha ap.Cmde];
x = inv(A)*b;

alpha_trim=x(1);
elevator_trim = x(2);