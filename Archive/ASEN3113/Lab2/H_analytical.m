clear;
clc;
close;

%% Analytical Model

k_Alum = 130;
k_Brass = 115;
k_Steel = 16.2;

V_Alum_1 = 26; %V
I_Alum_1 = 0.25; %A
V_Alum_2 = 28;
I_Alum_2 = 0.269;
V_Brass_1 = 26;
I_Brass_1 = 0.245;
V_Brass_2 = 29;
I_Brass_2 = 0.273;
V_Steel = 21;
I_Steel = 0.192;

%Rate of Heat into rod
Q_dot_Alum_1 = V_Alum_1*I_Alum_1;
Q_dot_Alum_2 = V_Alum_2*I_Alum_2;
Q_dot_Brass_1 = V_Brass_1*I_Brass_1;
Q_dot_Brass_2 = V_Brass_2*I_Brass_2;
Q_dot_Steel = V_Steel*I_Steel;

%Analytical H slope
r = (0.5*2.54)/100; %m
A = pi*r^2;
H_an_Alum_1 = (Q_dot_Alum_1/(k_Alum*A));
H_an_Alum_2 = Q_dot_Alum_2/(k_Alum*A);
H_an_Brass_1 = Q_dot_Brass_1/(k_Brass*A);
H_an_Brass_2 = Q_dot_Brass_2/(k_Brass*A);
H_an_Steel = Q_dot_Steel/(k_Steel*A);



