%% Example Size Distribution Figure
clear, close all

% Import data from Excel:
%SMPS
file=   'Marshall_SMPS_IntialSizeDistribution.xlsx';
sheet=  'Sheet1';
d=      xlsread(file,sheet,'A23:A128'); %diameter Dp
BG1=    xlsread(file,sheet,'J23:J128'); %background 1
BG2=    xlsread(file,sheet,'K23:K128'); %background 2
BG3=    xlsread(file,sheet,'L23:L128');%background 3
BG4=    xlsread(file,sheet,'M23:M128'); %background 4
BG5=    xlsread(file,sheet,'N23:N128'); %background 5
Ex1=    xlsread(file,sheet,'B23:B128'); %experiment 1
Ex2=    xlsread(file,sheet,'C23:C128'); %experiment 2
Ex3=    xlsread(file,sheet,'D23:D128'); %experiment 3
Ex4=    xlsread(file,sheet,'E23:E128'); %experiment 4
Ex5=    xlsread(file,sheet,'F23:F128'); %experiment 5

%APS
file2= 'Marshall_APS_IntialSizeDistribution.xlsx';
sheet= 'Sheet1';
d2=xlsread(file2,sheet,'A12:A62'); %diameter Dp
BG6=  xlsread(file2,sheet,'J12:J62');
BG7=  xlsread(file2,sheet,'K12:K62');
BG8=  xlsread(file2,sheet,'L12:L62');
BG9=  xlsread(file2,sheet,'M12:M62');
BG10=  xlsread(file2,sheet,'N12:N62');
Ex6=  xlsread(file2,sheet,'B12:B62');
Ex7=  xlsread(file2,sheet,'C12:C62');
Ex8=  xlsread(file2,sheet,'D12:D62');
Ex9=  xlsread(file2,sheet,'E12:E62');
Ex10=  xlsread(file2,sheet,'F12:F62');

%% Creating an experimental matrix to be able to plot using a for loop:
BGSMPS = [BG1 BG2 BG3 BG4 BG5];
ExSMPS = [Ex1 Ex2 Ex3 Ex4 Ex5];

BGAPS = [BG6 BG7 BG8 BG9 BG10];
ExAPS = [Ex6 Ex7 Ex8 Ex9 Ex10];

% Graphical parameters:
% Find colors and RGB codes at www.colorspire.com/rgb-color-wheel
LW = 2;    %Line thickness for plots
FS = 16;     %Font size
lblue = [79/255,166/255,203/255];
blue = [0/255,118/255,168/255];
dblue = [24/255 93/255 122/255];
lblack = [0.85 0.85 0.85];

% Plotting all datasets using a for loop:
for i = 1:5
    plot(d,BGSMPS(:,i),'LineWidth',LW,'Color','k')
    plot(d,ExSMPS(:,i),'LineWidth',LW,'Color',blue)
    hold on
end
hold off

xlabel('D_P(nm)')
ylabel('dN/dlog(D_P)')

set(gca,'XScale', 'log','Fontsize',FS, 'Linewidth',LW*.75) %axes parameters
set(gcf,'position',[10,10,600,300]) %dimensions of plot area

for i = 1:5
    plot(d2,BGAPS(:,i),'LineWidth',LW,'Color','k')
    plot(d2,ExAPS(:,i),'LineWidth',LW,'Color',blue)
    hold on
end
hold off

xlabel('D_P(nm)')
ylabel('dN/dlog(D_P)')

set(gca,'XScale', 'log','Fontsize',FS, 'Linewidth',LW*.75) %axes parameters
set(gcf,'position',[10,10,600,300]) %dimensions of plot area

% Average size dist:
BGAvg= mean(BGSMPS,2);
BGSD= std(BGSMPS,0,2);
ExAvg = mean(ExSMPS,2);
ExSD = std(ExSMPS,0,2);

BGAvgA= mean(BGAPS,2);
BGSDA= std(BGAPS,0,2);
ExAvgA = mean(ExAPS,2);
ExSDA = std(ExAPS,0,2);

%% Plotting average size dist with shaded region for std dev:
% The function flipud flips a column vector "up to down"
% If you have a row vector, use fliplr ("left to right")
x2 = [d;flipud(d)];  %new x vector that goes "there and back"

y_plusSMPS = ExAvg+ExSD;     %new top vector
y_minusSMPS = ExAvg-ExSD;      %new bottom vector
y2 = [y_plusSMPS;flipud(y_minusSMPS)]; %new y vector that goes "there and back"

y_plus1SMPS=BGAvg+BGSD;
y_minus1SMPS=BGAvg-BGSD;
y3=[y_plus1SMPS;flipud(y_minus1SMPS)];

x3 = [d2;flipud(d2)];  %new x vector that goes "there and back"

y_plusAPS = ExAvgA+ExSDA;       %new top vector
y_minusAPS = ExAvgA-ExSDA;      %new bottom vector
y4 = [y_plusAPS;flipud(y_minusAPS)]; %new y vector that goes "there and back"

y_plus1APS=BGAvgA+BGSDA;
y_minus1APS=BGAvgA-BGSDA;
y5=[y_plus1APS;flipud(y_minus1APS)];

fill(x2,y2,lblue,'EdgeColor','w')
hold on
plot(d,ExAvg,'LineWidth',LW,'Color',dblue)

fill(x2,y3,lblack,'EdgeColor','k')
hold on
plot(d,BGAvg,'LineWidth',LW,'Color','k')

xlabel('D_P(nm)')
ylabel('dN/dlog(D_P)')

set(gca,'XScale', 'log','Fontsize',FS, 'Linewidth',LW*.75) %axes parameters
set(gcf,'position',[10,10,600,300]) %dimensions of plot area
xlim([10 1000])
ylim([500 8500])
legend('','Afternoon Setup','','Background')

title('SMPS Size Distribution 01/08')

hold off

fill(x3,y4,lblue,'EdgeColor','w')
hold on
plot(d2,ExAvgA,'LineWidth',LW,'Color',dblue)

fill(x3,y5,lblack,'EdgeColor','k')
hold on
plot(d2,BGAvgA,'LineWidth',LW,'Color','k')


xlabel('D_P(nm)')
ylabel('dN/dlog(D_P)')

set(gca,'XScale', 'log','Fontsize',FS, 'Linewidth',LW*.75) %axes parameters
set(gcf,'position',[10,10,600,300]) %dimensions of plot area

legend('','Afternoon Setup','','Background')

fill(x2,y2,lblue,'EdgeColor','w')
plot(d,ExAvg,'LineWidth',LW,'Color',dblue)

fill(x2,y3,lblack,'EdgeColor','k')
plot(d,BGAvg,'LineWidth',LW,'Color','k')

xlabel('D_P(nm)')
ylabel('dN/dlog(D_P)')

fill(x3,y4,lblue,'EdgeColor','w')
plot(d2,ExAvgA,'LineWidth',LW,'Color',dblue)

fill(x3,y5,lblack,'EdgeColor','k')
plot(d2,BGAvgA,'LineWidth',LW,'Color','k')

xlabel('D_P(nm)')
ylabel('dN/dlog(D_P)')

set(gca,'XScale', 'log','Fontsize',FS, 'Linewidth',LW*.75) %axes parameters
set(gcf,'position',[10,10,600,300]) %dimensions of plot area

legend('','Afternoon Setup','','Background')

legend('Location','best')