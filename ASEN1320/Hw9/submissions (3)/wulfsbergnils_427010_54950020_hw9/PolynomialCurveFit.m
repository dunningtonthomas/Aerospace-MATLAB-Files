function [output] = PolynomialCurveFit(a,coeff)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

matrix = ones(length(a),1);         %Creating matrix of ones
results = 0;

for i =1:length(a)                  
    for y =1:6
        newValue = coeff(y).*a(i,y);    %Preforming calculations and storing it in arbitrary variable
        results = results + newValue;   %Taking sum of whole row
    end
    
    matrix(i) = results;                %Assighning results in final matrix
    results = 0;                        %Resetting sum variable for the next loop
end

output = matrix;
end