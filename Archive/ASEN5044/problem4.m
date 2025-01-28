%% Problem 4
close all; clear; clc;


%%
Ph = 0.5*0.05 / (0.5*0.05 + 0.5*0.92);
Ph0 = 1 - Ph;

Eh1 = Ph*100 + (1-Ph)*-10;

Eh2 = Ph * -1000;

% Update belief again
Ph_2 = Ph*0.05 / (Ph*0.05 + Ph0*0.92);
Ph0_2 = 1 - Ph_2;

% New utility
Eh1_2 = Ph_2*100 + (1-Ph_2)*-10;
Eh2_2 = Ph_2 * -1000;

% Part 2
Ph_3 = 0.5 * 0.95 / (0.5 * 0.95 + 0.5 * 0.08);
Ph0_3 = 1 - Ph_3;

% Update belief again
Ph_4 = Ph_3 * 0.05 / (Ph_3 * 0.05 + Ph0_3 * 0.92);
Ph0_4 = 1 - Ph_4;

% New utility
Eh1_3 = Ph_4*100 + (1-Ph_4)*-10;
Eh2_3 = Ph_4 * -1000;

