% Andrew Pearson
% ASEN 3113
% orbitfunc.m
% Created: 10/31/2022

clear; clc; close all

% TLE's obtained from n2yo.com on 11/6
TLE_GOES = {'GOES-16';
            '1 41866U 16071A   22310.30420875 -.00000249  00000-0  00000-0 0  9993';
            '2 41866   0.0443 273.6788 0000844 350.0574 176.1061  1.00270702 21889'};
    
TLE_ISS = {'ISS';
           '1 08709U 76019A   22310.50925348  .00000033  00000-0  94446-4 0  9998';
           '2 08709  69.6757   4.0237 0008115  54.2069  46.4769 13.71488897336265'};

[r_ECI,OE] = getInertialCoordinates(TLE_GOES,true,true);                     

