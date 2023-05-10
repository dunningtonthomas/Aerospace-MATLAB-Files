clc; clear;

%% ASEN 3200
clear;

atMid = 95;
atFinal = 100;

orbMid = 85.5;

HwAvg = 96.14;

LabAvg = 97.8;

individCurr = 0.4*(atMid + orbMid)/2 + 0.3*atFinal;

groupCurr = 0.7*LabAvg + 0.3*HwAvg;

curr = 0.5*individCurr + 0.5*groupCurr;

want = input("Enter desired grade (percent): ");

req = (want - curr)/15;

fprintf("Need %f percent on the Orbital final\n \n", req*100);

