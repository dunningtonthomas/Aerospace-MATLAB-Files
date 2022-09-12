%% Clean Up
close all; clear; clc;

%% Interval Scheduling

int1 = [4; 22];
int2 = [7; 9];
int3 = [10; 12];
int4 = [13; 15];
int5 = [16; 18];


%% Plotting
figure();
plot(int1, ones(1,length(int1)), 'linewidth', 2);
hold on
set(0, 'defaulttextinterpreter', 'latex');
set(gca,'YTickLabel',[]);
plot(int2, 1.5*ones(1,length(int2)), 'linewidth', 2);
plot(int3, 1.5*ones(1,length(int3)), 'linewidth', 2);
plot(int4, 1.5*ones(1,length(int4)), 'linewidth', 2);
plot(int5, 1.5*ones(1,length(int5)), 'linewidth', 2);

ylim([0.5 2]); 
xlim([3 24]);

title('Events over time');
xlabel('Time (hours)');
legend('Event 1, Weight: 1', 'Event 2, Weight: 5', 'Event 3, Weight: 5', 'Event 4, Weight: 5', 'Event 5, Weight: 5');


