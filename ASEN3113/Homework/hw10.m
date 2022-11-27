%% Clean Up
clear; close all; clc;

%% Problem 1

NuFunc = @(Ra, Pr)((0.825 + (0.387*Ra^(1/6)/(1 + (0.492/Pr)^(9/16))^(8/27)))^2);

Nu1 = NuFunc(33891416.38, 0.7282);

NuFinal = NuFunc(30021886.35, 0.72948);


%% Problem 2
NuVert = NuFunc(17553683.18, 0.7275);

NuVert2 = NuFunc(18676991.09, 0.7275);



%% Problem 3
NuFuncSphere = @(Ra, Pr)((2 + (0.589*Ra^(1/4)/(1 + (0.469/Pr)^(9/16))^(4/9))));

NuFirst = NuFuncSphere(2628527.389, 0.7111);

NuNext = NuFuncSphere(2610346.1, 0.7111);




