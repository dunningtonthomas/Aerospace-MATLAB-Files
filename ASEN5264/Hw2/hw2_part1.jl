using LinearAlgebra

## Problem 2
Tpi = [0 0.5 0.5; 1 0 0; 1 0 0];
Rpi = [0; 2; -1];
g = 0.95
Imat = I(3)

Upi = (Imat - 0.95*Tpi) \ Rpi;


@show Upi




