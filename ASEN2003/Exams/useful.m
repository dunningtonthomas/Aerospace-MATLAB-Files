%% Q1
close all; clear; clc;

%Creating equation
syms x(t);
x(t) = 2 - 3.463*exp(-2*t)*sin(1.414*t + 0.615);   %Input Value Here
time = linspace(0,10,1000);

%Solving using MATLAB
G = tf([140], [1 3.5 144]);                           %Input Value Here
[xC,tC] = step(G);
[xCi, tCi] = impulse(G);
t = linspace(0,10,1000);
ut = sin(2*pi*t);
[xCc, tCc] = lsim(G, ut, t);

stepInf = stepinfo(G, 'SettlingTimeThreshold', 0.05);
natInf = lsiminfo(tCi, xCi);


%Plots

%Using calculated equation
figure(1);
plot(time, x(time));
grid on
title('Time Evolution');
xlabel('Time (s)');
ylabel('x(t)');
xlim([0 4]);

%Using MATLAB
figure(2);
plot(tCc, xCc);                                   %Change depending on impulse (natural) or step
grid on
title('MATLAB CALC');
xlabel('Time (s)');
ylabel('x(t)');

%Characteristics

%Steady State
xss = 1;                                        %Input Value Here

%Rise Time
xFunc = x(time);
[peakVal, ind] = max(xFunc);
timePeak = time(ind);
timeInd= time < timePeak;
xFuncRise = xFunc(timeInd);
timeRise = time(timeInd);
nineXss = xss * 0.9;
oneXss = xss * 0.1;
[~,ind1] = min(abs(xFuncRise - oneXss));
[~,ind2] = min(abs(xFuncRise - nineXss));
t1 = timeRise(ind1);
t2 = timeRise(ind2);
riseTime = t2 - t1;

%% Q2 
close all; clear; clc;






%% Q3
close all; clear; clc;








%% Q4
close all; clear; clc;






