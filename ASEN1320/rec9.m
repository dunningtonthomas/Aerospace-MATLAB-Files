%% Clean Up
close all; clear; clc;

x = 1:10;
y = 1:10;


% plotFunc(x,y);


N = 10;
k = 5;
X = ones(N,k+1);

for j = 2:length(X(1,:))
    X(1,j) = j;
    
end



%% Nested For Loop
mat = ones(5,10);

for i = 1:10
    for j = 1:5
        
        mat(j,i) = i+j;
        
    end
end

xVec = linspace(1,10,1000);

L = length(xVec);

mat(2,3) = 10000;



