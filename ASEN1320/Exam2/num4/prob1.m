close all;clear all;clc;

x = linspace(-1,3,100);

y(x) = [a b c];


for i= 1:length(x)
    if (-1<=i)&&(i<0)
        a =(x^2+1)/(x^2+x);

    else if (0<=i)&&(i<2.718)
            b = 15*log(x);

    else (2.718<=i)&&(i<=3)
                c=12.386-(x^2);

    end
    end
end
tspan= [-1,3];
title('Problem 1');
xlabel('x');
ylabel('y(x)');
LineSpec='c-';
xticks(-1:3);
yticks(-70:20);
Plot(y(x),LineSpec)
grid on;


