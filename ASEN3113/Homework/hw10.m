%% Clean Up
clear; close all; clc;

%% Problem 1

NuFunc = @(Ra, Pr)((0.825 + (0.387*Ra^(1/6)/(1 + (0.492/Pr)^(9/16))^(8/27)))^2);

Nu1 = NuFunc(9058816414, 5.42);

Nu2 = NuFunc(5695971703, 6.14);

NuFinal = NuFunc(6519556943, 5.888);


%% Problem 2
NuVert = NuFunc(17553683.18, 0.7275);

NuVert2 = NuFunc(18676991.09, 0.7275);



%% Problem 3
NuFuncSphere = @(Ra, Pr)((2 + (0.589*Ra^(1/4)/(1 + (0.469/Pr)^(9/16))^(4/9))));

NuFirst = NuFuncSphere(2628527.389, 0.7111);

NuNext = NuFuncSphere(2610346.1, 0.7111);



%% Problem 2 graphing
area = 0.2*0.15;
sig = 5.67 * 10^-8;

h = 4.793119;

funkyBoi = @(x)(h*area*(x - 20) + sig*0.8*area*((x+273).^4 - 293^4) - 8);

figure();
fplot(funkyBoi, [0 50]);
hold on
zero1 = fzero(funkyBoi, 45);

plot(zero1, 0, '.', 'markersize', 20);
yline(0, '--', 'color', 'r');

xlabel('Surface Temperature C');
ylabel('Heat Transfer W');

title('Vertical Plate');


%next part
h2 = 6.7001515;
funkyBoi2 = @(x)(h2*area*(x - 20) + sig*0.8*area*((x+273).^4 - 293^4) - 8);

figure();
fplot(funkyBoi2, [0 50]);
hold on
zero1 = fzero(funkyBoi2, 45);

plot(zero1, 0, '.', 'markersize', 20);
yline(0, '--', 'color', 'r');

xlabel('Surface Temperature C');
ylabel('Heat Transfer W');

title('Horizontal Plate Hot Side Up');


%next part
h3 = 3.347610;
funkyBoi3 = @(x)(h3*area*(x - 20) + sig*0.8*area*((x+273).^4 - 293^4) - 8);

figure();
fplot(funkyBoi3, [0 60]);
hold on
zero1 = fzero(funkyBoi3, 45);

plot(zero1, 0, '.', 'markersize', 20);
yline(0, '--', 'color', 'r');

xlabel('Surface Temperature C');
ylabel('Heat Transfer W');

title('Horizontal Plate Hot Side Down');


