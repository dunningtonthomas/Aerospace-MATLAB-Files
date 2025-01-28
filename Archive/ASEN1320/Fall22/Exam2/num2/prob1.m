clc;clear;close all;

%Variable Declaration
x=linspace(-1,3,100);
y=zeros(1,length(x));

%For-loop for calculating y(x)
for i=1:length(x)
    if ( x>=-1 & x<0 )
         y(i) = (x(i)^2+1)/(x(i)^2+x(i));
    elseif ( x>=0 & x<2.718 )
        y(i) = 15*log(x(i));
    elseif ( x>=2.718 & x<=3 )
        y(i) = 12.386-x(i)^2;
    end
end

%Plotting the function
plot(x,y,'-c');
grid on;