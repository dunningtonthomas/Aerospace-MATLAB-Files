function [Output] = BuildMatrix(a,poly)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
X = ones(length(a),poly+1);             %Creating matrix of ones
for y=2:poly+1                          %Starting on second column
    for i=1:length(a)                   %Going alll the way to Nth value
            X(i,y) = a(i).^(y-1);       %Setting up the polynomial
    end 
end

Output = X;
end