function motor_forces = ComputeMotorForces(Fc, Gc, d, km)
%COMPUTEMOTORFORCES This function calculates the individual motor forces on
%the Quadrotor given the control force and moments
%Inputs: Fc = control force vector; Gc = control moment vector; d = radial
%distance from the CG to the motors; km = control moment coefficient.
%Outputs: motor_forces = [f1;f2;f3;f4] where f is the motor force


%mat is the matrix to get the control force and moments from the motor
%forces
mat = [-1,-1,-1,-1;
    -d/sqrt(2), -d/sqrt(2), d/sqrt(2), d/sqrt(2);
    d/sqrt(2), -d/sqrt(2), -d/sqrt(2), d/sqrt(2);
    km, -km, km, -km];

%Inverting the matrix to solve for the motor forces
invMat = inv(mat);

%Vector of control forces and moments
contVec = [Fc(3); Gc(1); Gc(2); Gc(3)];


%Multiplying to solve for the motor forces
motor_forces =  mat \ contVec; %This is the same as invMat * contVec


end

