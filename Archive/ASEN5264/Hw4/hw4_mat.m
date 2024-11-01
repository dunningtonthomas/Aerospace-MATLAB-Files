%% Clean
close all; clear; clc;


%% Plot PDF
x = 0:0.01:1;
y1 = betapdf(x,1,2);
y2 = betapdf(x,2,1);
y3 = betapdf(x,4,3);

plot(x,y1)
hold on
plot(x,y2)
plot(x,y3)
legend(["Arm 1 Beta(1,2)","Arm 2 Beta(2,1)","Arm 3 Beta(4,3)"]);
hold off

xlabel("Payoff Probability")
ylabel("Probability Density")
title("Posterior Distributions")