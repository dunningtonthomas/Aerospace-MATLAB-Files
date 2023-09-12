function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)
%PLLT
%
%Summary: This function solves the prandlt lifting line theory equation to
%get the span efficiency factor, the coefficient of lift, and the induced
%coefficient of drag
%
%   Author: Thomas Dunnington
%   Collaborators: Nolan Stevenson, Carson Kohlbrenner, Chase Rupprecht,
%   Owen Craig
%   Date: 4/5/2023
%
%INPUTS: 
%   b = span
%   a0_t = cross sectional lift slope at the tips (per radian)
%   a0_r = cross sectional lift slope at the root (per radian)
%   c_t = chord at the tip
%   c_r = chord at the root
%   aero_t = zero lift angle of attack at the tip (rad)
%   aero_r = zero lift angle of attack at the root (rad)
%   geo_t = geometetric angle of attack at the tip (rad)
%   geo_r = geometetric angle of attack at the root (rad)
%   N = number of odd terms to include in the series expansion
%   
%OUTPUTS: 
%   e = span efficiency factor
%   c_L = coefficient of lift
%   c_Di = coefficient of drag
%   

%Need to determine the coefficients A1, A3, A5,....., AN
%Prealocating memory for the matrices
Amat = zeros(N,N);
bmat = zeros(N,1);

%Creating vector of theta values
nVals = 1:N;
thetaVec = pi / (2*N) .* nVals;

%Defining values of lift slope
a = (a0_t - a0_r).*cos(thetaVec) + a0_r*ones(1,N);

%Defining values of chord
c = (c_t - c_r).*cos(thetaVec) + c_r*ones(1,N);

%Defining values of zero lift aoa
aero = (aero_t - aero_r).*cos(thetaVec) + aero_r*ones(1,N);

%Defining values of geometric angle of attack
geo = (geo_t - geo_r).*cos(thetaVec) + geo_r*ones(1,N);


%Looping through theta vector
for i = 1:N     
    %Calculating bmat
    bmat(i) = geo(i) - aero(i);
    
    %Calculating Amat
    coeff = 4*b / (a(i)*c(i)); %Coefficient of first summation in PLLT eq
    theta = thetaVec(i); %Defining theta
    for j = 1:N
        Amat(i,j) = coeff * sin((2*j - 1)*theta) + (2*j - 1) * sin((2*j - 1)*theta) / sin(theta);
    end    
end

%Solving the system of equations to get the A coefficients
Avals = Amat \ bmat;


%Calculating aspect ratio
cy = (c_t - c_r)/(b/2).*linspace(0,b/2,N) + c_r*ones(1,N);
S = 2*trapz(linspace(0,b/2,N), cy);
% S = 2 * trapz(thetaVec, b/2 .* sin(thetaVec) .* c);
AR = b^2 / S;

%Coefficient of lift
c_L = Avals(1) * pi * AR;

%Calculating delta
delta = 0;
for i = 2:length(Avals)
    delta = delta + (2*i - 1)*(Avals(i) / Avals(1))^2;
end

%Calculating Cdi and e
e = 1 / (1 + delta);
c_Di = c_L^2 / (pi*e*AR);

end

