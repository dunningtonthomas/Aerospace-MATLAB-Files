close all; clear all; clc;

%Variable declaration
x0 = -1;
xf = 3;
n = 100;

%X vector initialization
x = linspace(x0,xf,n);

%Y vector initialization
y = zeros(1,length(x));

%For loop to determine y for every x
for i = 1:length(x)
    %Conditional statements to determine which function to evaluate at x
    if x(i) >= -1 && x(i) < 0
        y(i) = (x(i)^2+1)/(x(i)^2+x(i));
    elseif x(i) >= 0 && x(i) < 2.718
        y(i) = 15*log(x(i));
    elseif x(i) >=2.718 && x(i) < 3
        y(i) = 12.386 - x(i)^2;
    end
end

%Plotting in cyan
plot(x,y,'c');
grid on;

