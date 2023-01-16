function plotMotorForces(time, motorForces,fig,col)

%This function Plots the motor forces to the figure specified by fig and
%the plot options specified by col

figure(fig);
subplot(4,1,1)
plot(time, motorForces(:,1), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$f_{1}$$ (N)');
title('Motor Forces');

limits = yLimCalc(motorForces(:,1));
ylim(limits);

subplot(4,1,2)
plot(time, motorForces(:,2), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$f_{2}$$ (N)');

limits = yLimCalc(motorForces(:,2));
ylim(limits);

subplot(4,1,3)
plot(time, motorForces(:,3), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$f_{3}$$ (N)');

limits = yLimCalc(motorForces(:,3));
ylim(limits);

subplot(4,1,4)
plot(time, motorForces(:,4), col, 'linewidth', 2);
hold on;
grid on;
ylabel('$$f_{4}$$ (N)');

xlabel('Time (s)');

limits = yLimCalc(motorForces(:,4));
ylim(limits);



end

