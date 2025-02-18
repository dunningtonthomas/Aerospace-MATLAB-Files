%% Clean Up
clear; close all; clc;


%% Parameters
%Constants
sigma = 5.67 * 10^-8;

%Radiator params
area = 0.2863;
alphaSolar = 0.2;
alphaIR = 0.85;
epsilon = 0.85;

%Solar constants
Gs = (5.67*10^-8)*(5771.5^4);
radSum = 215*(1+0.0167);
radWin = 215*(1-0.0167);

fluxEq = Gs / (215^2);
% fluxSum = 1361 - 0.033*1361; %3.3 variation in flux
% fluxWin = 1361 + 0.033*1361; %3.3 variation in flux
fluxSum = Gs / (radSum^2); %3.3 variation in flux
fluxWin = Gs / (radWin^2); %3.3 variation in flux

%Angle of earth's tilt
tilt = 23.5*pi/180;

%Length of time in the shadow
radEarth = 6371;
radOrbit = 42164;

angleShadow = 2*atan2(radEarth,radOrbit);

timeShadow = (angleShadow / (2*pi))* 24 * 3600;
%% Energy Balance Equations
time = 1:12*3600; %12 hours for midnight to noon
theta = linspace(0, pi, length(time)); %Theta for the 12 hours

time2 = time(end)+1:24*3600;

thetaTot = linspace(0, pi, length(time) + length(time2));

%%%%SUMMER SOLSTICE
%%Operation
TempSS_Op = ((1/(area*epsilon*sigma))*(20 + alphaSolar*fluxSum*area*cos(tilt)*sin(theta) + 63*area*alphaIR)).^(1/4);
TempSS_Op_Const = ((1/(area*epsilon*sigma))*(20 + 63*area*alphaIR)).^(1/4);

%%Survival
TempSS_S = ((1/(area*epsilon*sigma))*(alphaSolar*fluxSum*area*cos(tilt)*sin(theta) + 63*area*alphaIR)).^(1/4);
TempSS_S_Const = ((1/(area*epsilon*sigma))*(63*area*alphaIR)).^(1/4);

%%Absorbed solar radiation
qSS = alphaSolar*fluxSum*area*cos(tilt)*sin(theta);


%%%%WINTER SOLSTICE
%%Operation
TempWS_Op = ((1/(area*epsilon*sigma))*(20 + alphaSolar*fluxWin*area*cos(tilt)*sin(theta) + 88*area*alphaIR)).^(1/4);
TempWS_Op_Const = ((1/(area*epsilon*sigma))*(20 + 88*area*alphaIR)).^(1/4);

%%Survival
TempWS_S = ((1/(area*epsilon*sigma))*(alphaSolar*fluxWin*area*cos(tilt)*sin(theta) + 88*area*alphaIR)).^(1/4);
TempWS_S_Const = ((1/(area*epsilon*sigma))*(88*area*alphaIR)).^(1/4);

%%Absorbed solar radiation
qWS = alphaSolar*fluxWin*area*cos(tilt)*sin(theta);

%%%%EQUINOX
%%Operation
TempE_Op = ((1/(area*epsilon*sigma))*(20 + alphaSolar*fluxEq*area*sin(theta) + 75.5*area*alphaIR)).^(1/4);
TempE_Op_Const = ((1/(area*epsilon*sigma))*(20 + 75.5*area*alphaIR)).^(1/4);

%Eclipse
TempOp_Eclipse = ((1/(area*epsilon*sigma))*(11*area))^(1/4);

%%Survival
TempE_S = ((1/(area*epsilon*sigma))*(alphaSolar*fluxEq*area*sin(theta) + 75.5*area*alphaIR)).^(1/4);
TempE_S_Const = ((1/(area*epsilon*sigma))*(75.5*area*alphaIR)).^(1/4);

%%Absorbed solar radiation
qE = alphaSolar*fluxEq*area*sin(theta);
thetaLog = theta >= (pi - (1/2)*angleShadow);
qE(thetaLog) = 0;


%Eclipse
TempS_Eclipse = ((1/(area*epsilon*sigma))*(11*area))^(1/4);

%Concatenating so during the time period in eclipse we get the correct
%temperature
thetaLog = theta >= (pi - (1/2)*angleShadow);
timeLog = time(thetaLog);
TempE_Op(thetaLog) = TempOp_Eclipse;
TempE_S(thetaLog) = TempS_Eclipse;

%Finding the time interval in eclipse
timeInt = timeLog(end) - timeLog(1);

%Concatenating the eclipse into the second half
timeLog = time2 <= (time2(1) + timeInt);

TempE_Op_Const_Plot = ones(1, length(time2))*TempE_Op_Const;
TempE_Op_Const_Plot(timeLog) = ones(1, sum(timeLog))*TempOp_Eclipse;
TempE_S_Const_Plot = ones(1, length(time2))*TempE_S_Const;
TempE_S_Const_Plot(timeLog) = ones(1, sum(timeLog))*TempS_Eclipse;


%% Determining the Heater Power
%%%%SUMMER SOLSTICE
%Operation
QH_SS_Op = area*epsilon*sigma*(20+273)^(4) - 20 - (alphaSolar*fluxSum*area*cos(tilt)*sin(theta)) - 63*area*alphaIR;
QH_SS_Op_Const = area*epsilon*sigma*(20+273)^(4) - 20 - 63*area*alphaIR;

%Truncate so we have 0 power when we are above the required temperature
logVec = QH_SS_Op < 0;
QH_SS_Op(logVec) = 0;

%Survival
QH_SS_S = area*epsilon*sigma*(-40+273)^(4) - (alphaSolar*fluxSum*area*cos(tilt)*sin(theta)) - 63*area*alphaIR;
QH_SS_S_Const = area*epsilon*sigma*(-40+273)^(4) - 63*area*alphaIR;

%Truncate so we have 0 power when we are above the required temperature
logVec = QH_SS_S < 0;
QH_SS_S(logVec) = 0;


%%%%WINTER SOLSTICE
%Operation
QH_WS_Op = area*epsilon*sigma*(20+273)^(4) - 20 - (alphaSolar*fluxWin*area*cos(tilt)*sin(theta)) - 88*area*alphaIR;
QH_WS_Op_Const = area*epsilon*sigma*(20+273)^(4) - 20 - 88*area*alphaIR;

%Truncate so we have 0 power when we are above the required temperature
logVec = QH_WS_Op < 0;
QH_WS_Op(logVec) = 0;

%Survival
QH_WS_S = area*epsilon*sigma*(-40+273)^(4) - (alphaSolar*fluxWin*area*cos(tilt)*sin(theta)) - 88*area*alphaIR;
QH_WS_S_Const = area*epsilon*sigma*(-40+273)^(4) - 88*area*alphaIR;

%Truncate so we have 0 power when we are above the required temperature
logVec = QH_WS_S < 0;
QH_WS_S(logVec) = 0;


%%%%EQUINOX
timeTot = [time, time2];
TempE_OpTOT = [TempE_Op, TempE_Op_Const_Plot];
TempE_STOT = [TempE_S, TempE_S_Const_Plot];

%Operation
QH_E_Op = area*epsilon*sigma*(20+273)^(4) - 20 - (alphaSolar*fluxSum*area*sin(theta)) - 75.5*area*alphaIR;
QH_E_Op_Const = area*epsilon*sigma*(20+273)^(4) - 20 - 75.5*area*alphaIR;
QH_E_Op_Eclipse = area*epsilon*sigma*(20+273)^(4) - 11*area*alphaIR;

%Survival
QH_E_S = area*epsilon*sigma*(-40+273)^(4) - (alphaSolar*fluxSum*area*sin(theta)) - 75.5*area*alphaIR;
QH_E_S_Const = area*epsilon*sigma*(-40+273)^(4) - 75.5*area*alphaIR;
QH_E_S_Eclipse = area*epsilon*sigma*(-40+273)^(4) - 11*area*alphaIR;

%Concatenating so during the time period in eclipse we get the correct
%temperature
thetaLog = theta >= (pi - (1/2)*angleShadow);
timeLog = time(thetaLog);
QH_E_Op(thetaLog) = QH_E_Op_Eclipse;
QH_E_S(thetaLog) = QH_E_S_Eclipse;

%Finding the time interval in eclipse
timeInt = timeLog(end) - timeLog(1);

%Concatenating the eclipse into the second half
timeLog = time2 <= (time2(1) + timeInt);

QH_E_Op_Const_Plot = ones(1, length(time2))*QH_E_Op_Const;
QH_E_Op_Const_Plot(timeLog) = ones(1, sum(timeLog))*QH_E_Op_Eclipse;
QH_E_S_Const_Plot = ones(1, length(time2))*QH_E_S_Const;
QH_E_S_Const_Plot(timeLog) = ones(1, sum(timeLog))*QH_E_S_Eclipse;

%Zero Out heater power
QH_E_Op(QH_E_Op < 0) = 0;
QH_E_S(QH_E_S < 0) = 0;
QH_E_Op_Const_Plot(QH_E_Op_Const_Plot < 0) = 0;
QH_E_S_Const_Plot(QH_E_S_Const_Plot < 0) = 0;


%% Plotting
%%%%SUMMER SOLSTICE
%% Summer Combined
figure();
set(0, 'defaulttextinterpreter', 'latex');

yyaxis left

op = plot(time / 3600, TempSS_Op - 273, 'linewidth', 2, 'color', 'r');
hold on
plot(time2 / 3600, ones(1, length(time2))*(TempSS_Op_Const - 273), 'linewidth', 2, 'color', 'r', 'linestyle', '-');
s = plot(time / 3600, TempSS_S - 273, 'linewidth', 2, 'color', rgb('mango'), 'linestyle', '-');
plot(time2 / 3600, ones(1, length(time2))*(TempSS_S_Const - 273), 'linewidth', 2, 'color', rgb('mango'), 'linestyle', '-');


yline(20, 'linewidth', 2, 'color', 'k', 'linestyle', '--', 'label', 'Required Operational Range');
yline(30, 'linewidth', 2, 'color', 'k', 'linestyle', '--');
yline(-40, 'linewidth', 2, 'color', 'k', 'linestyle', '--', 'label', 'Required Survival Temperature');


ylabel('Temperature $$(^{\circ}C)$$');
ylim([-100 40]);
xlim([0 24]);

%Heater power on the right
yyaxis right
ylabel('Heater Power (W)');
Qop = plot(time / 3600, QH_SS_Op, 'linewidth', 2, 'color', 'b');
hold on
plot(time2 / 3600, ones(1,length(time2))*QH_SS_Op_Const, 'linewidth', 2, 'color', 'b', 'linestyle', '-');

Qs = plot(time / 3600, QH_SS_S, 'linewidth', 2, 'color', [0.3010 0.7450 0.9330], 'linestyle', '-');
plot(time2 / 3600, ones(1,length(time2))*QH_SS_S_Const, 'linewidth', 2, 'color', [0.3010 0.7450 0.9330], 'linestyle', '-');

title('Summer Solstice Temperature and Power');
xlabel('Time (hours)');

%Setting the colors of the axis
ax = gca;
ax.YAxis(1).Color = 'r';
ax.YAxis(2).Color = 'b';

%Legend
legend([op, s, Qop, Qs], 'Operational Temp', 'Survival Temp', 'Operational Power', 'Survival Power', 'location', 'best');

%Setting xticks
xticks([0 6 12 18 24])
xticklabels({'0 (Noon)','6','12 (Midnight)','18','24 (Noon)'})

%Summer Solstice Survival
% figure();
% set(0, 'defaulttextinterpreter', 'latex');
% 
% yyaxis left
% 
% plot(time / 3600, TempSS_S - 273, 'linewidth', 2, 'color', 'r');
% hold on
% plot(time2 / 3600, ones(1, length(time2))*(TempSS_S_Const - 273), 'linewidth', 2, 'color', 'r', 'linestyle', '-');
% 
% yline(-40, 'linewidth', 2, 'color', 'r', 'linestyle', '--', 'label', 'Required Minimum Temperature');
% 
% ylabel('Temperature $$(^{\circ}C)$$');
% ylim([-100 40]);
% 
% %Heater power on the right
% yyaxis right
% ylabel('Heater Power (W)');
% plot(time / 3600, QH_SS_S, 'linewidth', 2, 'color', 'b');
% hold on
% plot(time2 / 3600, ones(1,length(time2))*QH_SS_S_Const, 'linewidth', 2, 'color', 'b', 'linestyle', '-');
% 
% title('Summer Solstice Survival');
% xlabel('Time (hours)');
% 
% %Setting the colors of the axis
% ax = gca;
% ax.YAxis(1).Color = 'r';
% ax.YAxis(2).Color = 'b';


%% Winter Combined
figure();

yyaxis left

op = plot(time / 3600, TempWS_Op - 273, 'linewidth', 2, 'color', 'r');
hold on
plot(time2 / 3600, ones(1, length(time2))*(TempWS_Op_Const - 273), 'linewidth', 2, 'color', 'r', 'linestyle', '-');
s = plot(time / 3600, TempWS_S - 273, 'linewidth', 2, 'color', rgb('mango'), 'linestyle', '-');
plot(time2 / 3600, ones(1, length(time2))*(TempWS_S_Const - 273), 'linewidth', 2, 'color', rgb('mango'), 'linestyle', '-');


yline(20, 'linewidth', 2, 'color', 'k', 'linestyle', '--', 'label', 'Required Operational Range');
yline(30, 'linewidth', 2, 'color', 'k', 'linestyle', '--');
yline(-40, 'linewidth', 2, 'color', 'k', 'linestyle', '--', 'label', 'Required Survival Temperature');


ylabel('Temperature $$(^{\circ}C)$$');
ylim([-100 40]);
xlim([0 24]);

%Heater power on the right
yyaxis right
ylabel('Heater Power (W)');
Qop = plot(time / 3600, QH_WS_Op, 'linewidth', 2, 'color', 'b');
hold on
plot(time2 / 3600, ones(1,length(time2))*QH_WS_Op_Const, 'linewidth', 2, 'color', 'b', 'linestyle', '-');

Qs = plot(time / 3600, QH_WS_S, 'linewidth', 2, 'color', [0.3010 0.7450 0.9330], 'linestyle', '-');
plot(time2 / 3600, ones(1,length(time2))*QH_WS_S_Const, 'linewidth', 2, 'color', [0.3010 0.7450 0.9330], 'linestyle', '-');

title('Winter Solstice Temperature and Power');
xlabel('Time (hours)');

%Setting the colors of the axis
ax = gca;
ax.YAxis(1).Color = 'r';
ax.YAxis(2).Color = 'b';

%Legend
legend([op, s, Qop, Qs], 'Operational Temp', 'Survival Temp', 'Operational Power', 'Survival Power', 'location', 'best');

%Setting xticks
xticks([0 6 12 18 24])
xticklabels({'0 (Noon)','6','12 (Midnight)','18','24 (Noon)'})

% 
% %%%%WINTER SOLSTICE
% %Winter Solstice Operational
% figure();
% set(0, 'defaulttextinterpreter', 'latex');
% 
% yyaxis left
% 
% plot(time / 3600, TempWS_Op - 273, 'linewidth', 2, 'color', 'r');
% hold on
% plot(time2 / 3600, ones(1, length(time2))*(TempWS_Op_Const - 273), 'linewidth', 2, 'color', 'r', 'linestyle', '-');
% 
% yline(20, 'linewidth', 2, 'color', 'r', 'linestyle', '--', 'label', 'Required Temperature Range');
% yline(30, 'linewidth', 2, 'color', 'r', 'linestyle', '--');
% 
% ylabel('Temperature $$(^{\circ}C)$$');
% ylim([-60 40]);
% 
% %Heater power on the right
% yyaxis right
% ylabel('Heater Power (W)');
% plot(time / 3600, QH_WS_Op, 'linewidth', 2, 'color', 'b');
% hold on
% plot(time2 / 3600, ones(1,length(time2))*QH_WS_Op_Const, 'linewidth', 2, 'color', 'b', 'linestyle', '-');
% 
% title('Winter Solstice Operational');
% xlabel('Time (hours)');
% 
% %Setting the colors of the axis
% ax = gca;
% ax.YAxis(1).Color = 'r';
% ax.YAxis(2).Color = 'b';
% 
% 
% %Winter Solstice Survival
% figure();
% set(0, 'defaulttextinterpreter', 'latex');
% 
% yyaxis left
% 
% plot(time / 3600, TempWS_S - 273, 'linewidth', 2, 'color', 'r');
% hold on
% plot(time2 / 3600, ones(1, length(time2))*(TempWS_S_Const - 273), 'linewidth', 2, 'color', 'r', 'linestyle', '-');
% 
% yline(-40, 'linewidth', 2, 'color', 'r', 'linestyle', '--', 'label', 'Required Minimum Temperature');
% 
% ylabel('Temperature $$(^{\circ}C)$$');
% ylim([-80 40]);
% 
% %Heater power on the right
% yyaxis right
% ylabel('Heater Power (W)');
% plot(time / 3600, QH_WS_S, 'linewidth', 2, 'color', 'b');
% hold on
% plot(time2 / 3600, ones(1,length(time2))*QH_WS_S_Const, 'linewidth', 2, 'color', 'b', 'linestyle', '-');
% 
% title('Winter Solstice Survival');
% xlabel('Time (hours)');
% 
% %Setting the colors of the axis
% ax = gca;
% ax.YAxis(1).Color = 'r';
% ax.YAxis(2).Color = 'b';

%% Equinox Total
%%%%EQUINOX
%Equinox Operational
figure();
set(0, 'defaulttextinterpreter', 'latex');

yyaxis left

op = plot([time / 3600, time2 / 3600] , [TempE_Op - 273, TempE_Op_Const_Plot - 273],  'linewidth', 2, 'color', 'r');
hold on
s = plot([time / 3600, time2 / 3600] , [TempE_S - 273, TempE_S_Const_Plot - 273],  'linewidth', 2, 'color', rgb('mango'), 'linestyle', '-');

yline(20, 'linewidth', 2, 'color', 'k', 'linestyle', '--', 'label', 'Required Operational Range');
yline(30, 'linewidth', 2, 'color', 'k', 'linestyle', '--');
yline(-40, 'linewidth', 2, 'color', 'k', 'linestyle', '--', 'label', 'Required Survival Temperature');

ylabel('Temperature $$(^{\circ}C)$$');
ylim([-160 40]);
xlim([0 24]);

%Heater power on the right
yyaxis right
ylabel('Heater Power (W)');
Qop = plot([time / 3600, time2/3600], [QH_E_Op, QH_E_Op_Const_Plot] , 'linewidth', 2, 'color', 'b');
hold on
Qs = plot([time / 3600, time2/3600], [QH_E_S, QH_E_S_Const_Plot] , 'linewidth', 2, 'color', [0.3010 0.7450 0.9330], 'linestyle', '-');

ylim([0 105]);
title('Equinox Temperature and Power');
xlabel('Time (hours)');

%Setting the colors of the axis
ax = gca;
ax.YAxis(1).Color = 'r';
ax.YAxis(2).Color = 'b';

%Legend
legend([op, s, Qop, Qs], 'Operational Temp', 'Survival Temp', 'Operational Power', 'Survival Power', 'location', 'SE');

%Setting xticks
xticks([0 6 12 18 24])
xticklabels({'0 (Noon)','6','12 (Midnight)','18','24 (Noon)'})



%% Total Solar Flux for all three scenarios
figure();
plot([time / 3600, time2/3600], [qE, zeros(1,length(time2))] , 'linewidth', 2, 'color', rgb('light purple'));
hold on
plot([time / 3600, time2/3600], [qWS, zeros(1,length(time2))] , 'linewidth', 2, 'color', rgb('light red'));
plot([time / 3600, time2/3600], [qSS, zeros(1,length(time2))] , 'linewidth', 2, 'color', rgb('medium blue'));




%Setting xticks
xticks([0 6 12 18 24])
xticklabels({'0 (Noon)','6','12 (Midnight)','18','24 (Noon)'})
xlabel('Time (hours)');

ylabel('Radiation Absorbed (W)');
title('Solar Radiation Absorbed');

legend('Equinox', 'Winter Solstice','Summer Solstice');
