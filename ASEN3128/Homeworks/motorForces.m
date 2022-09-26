function forces = motorForces(controlVec, d, km)
%MOTORFORCES This function inverts the matrix relating the control moments
%and forces to the 4 control forces on the motors. Use this function to
%solve for the motor forces if you know the control force and moments (Zc
%Lc Mc and Nc)
%Inputs: Vector of the control force and moments in the form [Zc; Lc; Mc;
%Nc], d the radial distance to the arms where the motors are, and km the
%control moment coefficient
%Outputs: Vector of the motor forces in the form [f1; f2; f3; f4]

mat = [-1,-1,-1,-1;
    -d/sqrt(2), -d/sqrt(2), d/sqrt(2), d/sqrt(2);
    d/sqrt(2), -d/sqrt(2), -d/sqrt(2), d/sqrt(2);
    km, -km, km, -km];

matInv = inv(mat);

%forces = matInv*controlVec;
forces = mat\controlVec;

end

