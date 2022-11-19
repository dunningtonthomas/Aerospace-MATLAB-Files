close all;clear;clc; %Housekeeping

x = linspace(-1,3,100); %linspace makes x vector
y = zeros(1,length(x)); %initialize y vector to length of x

%For loop checks for value of x(i) and applies appropriate equation based
%on its bounds and the bounds dictated in the paper
for i=1:length(x) 
if x(i) >= -1 && x(i) < 0 
    y(i) = (x(i)^2 + 1) / (x(i)^2 + x(i));
elseif x(i) >= 0 && x(i) < 2.718
y(i) = 15 * log(x(i));
elseif x(i) > 2.718 && x(i) <= 3
y(i) = 12.386 - x(i)^2;
end

%Plot graph. I am making the assumption that the default color is cyan
%because it looks cyan. In the paper, the line appeared to have a width of
%2 so I set it to be that way. I was not told to, but the paper said to
%replicate the shown graph as best as possible.
plot(x,y,'LineWidth',2.0);
grid on;

end