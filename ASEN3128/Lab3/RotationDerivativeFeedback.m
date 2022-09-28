function [Fc, Gc] = RotationDerivativeFeedback(var, m, g) 
%ROTATIONDERIVATIVEFEEDBACK This function calculates the control vectors Fc
%and Gc which are the control force vector and the control moment vector
%Inputs: var = 12by1 state vector, m = mass, g = gravity
%Outputs: Fc = control force vector, Gc = control moment vector
%USE A GAIN of 0.004

%Controller gain
gain = 0.004;

%Getting the angular rates
p = var(10);
q = var(11);
r = var(12);


%Finding the control forces and moments
Zc = m * g;

Lc = -gain * p;

Mc = -gain * q;

Nc = -gain * r;


%Outputting the force and moment control vectors
Fc = [0;0;-Zc];
Gc = [Lc; Mc; Nc];

end

