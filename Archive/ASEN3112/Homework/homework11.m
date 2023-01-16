%% Clean Up
clear; close all; clc;

%% Problem 3

I = @(d)(pi/4)*((d/2)^4 - ((d/2)-0.01)^4);

Pcr = @(d,L)((pi^2 * 200*10^9 * I(d)) / L^2);

Pyield = @(d)(300*10^6 * pi*((d/2)^2 - ((d/2) - 0.01).^2));


%First one
Pcr1 = Pcr(60/1000, 1);
Pyield1 = Pyield(60/1000);

Pcr2 = Pcr(80/1000, 2);
Pyield2 = Pyield(80/1000);

Pcr3 = Pcr(100/1000, 3);
Pyield3 = Pyield(100/1000);

Pcr4 = Pcr(150/1000, 4);
Pyield4 = Pyield(150/1000);

Pcr5 = Pcr(200/1000, 5);
Pyield5 = Pyield(200/1000);

Pcr6 = Pcr(225/1000, 6);
Pyield6 = Pyield(225/1000);

Pcr7 = Pcr(250/1000, 7);
Pyield7 = Pyield(250/1000);



