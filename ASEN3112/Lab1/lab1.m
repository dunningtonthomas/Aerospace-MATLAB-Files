%% Clean Up 
close all; clear; clc;


%% Import Data
data20 = readmatrix('20inlbf_005.txt');
data400 = readmatrix('400inlbf_04.txt');

time20 = data20(:,1);
angle20 = data20(:,2) * pi/180;
shear20_ext = data20(:,3)* pi/180;
torque20 = data20(:,4);
axial20 = data20(:,5);


time400 = data400(:,1);
angle400 = data400(:,2) * pi/180;
shear400_ext = data400(:,3) * pi/180;
torque400 = data400(:,4);
axial400 = data400(:,5);

%% Truncating the data so it is only up to the maximum torque
%This is so it doesn't double back on itself
[~,torqueLim400] = min(torque400);

%OTW
[~,torqueLim20] = min(torque20);

%Truncate data up to the maximum torque value
time20 = time20(1:torqueLim20);
angle20 = angle20(1:torqueLim20);
shear20_ext = shear20_ext(1:torqueLim20);
torque20 = torque20(1:torqueLim20);
axial20 = axial20(1:torqueLim20);

time400 = time400(1:torqueLim400);
angle400 = angle400(1:torqueLim400);
shear400_ext = shear400_ext(1:torqueLim400);
torque400 = torque400(1:torqueLim400);
axial400 = axial400(1:torqueLim400);


%Constants
radiusAvg = (3/8 + (3/8 - 1/16)) / 2; %in, the average radius
radiusE = 3/8; %External radius
lengthAxial = 10; %in
length_ext = 1;
thickness = 1/16; %in
G = 3.75e6; %psi

%% Analysis Open Wall
%Finding the strain from the machine
angle20Norm = angle20 - angle20(1); %So the angle starts at zero
shear20_machine = angle20Norm * thickness / lengthAxial;

%Calculating dphi dx using the shear strain
%Machine
dPhi_dx20_machine = angle20Norm / lengthAxial; %This is dPhi dX

%Extensometer
dPhi_ext = shear20_ext * length_ext / thickness;
dPhi_dx20_ext = dPhi_ext / length_ext; %dPhi dx for extensometer


%Performing a linear regression
%Machine
coeff20_machine = polyfit(dPhi_dx20_machine, torque20, 1); %The slope is GJ

%Extensometer
coeff20_ext = polyfit(dPhi_dx20_ext, torque20, 1); %The slope is GJ

Gj_otw_ext = coeff20_ext(1);
Gj_otw_machine = coeff20_machine(1);


%% Analysis Closed Wall
%Finding the machine shear strain using the equation
angle400Norm = angle400 - angle400(1); %So the angle starts at zero
shear400_machine = angle400Norm * radiusE / lengthAxial;

%Calculating dphi dx using the shear strain
%Machine
dPhi_dx400_machine = angle400Norm / lengthAxial; %This is dPhi dX

%Extensometer
dPhi_ext = shear400_ext * length_ext / radiusE;
dPhi_dx400_ext = dPhi_ext / length_ext; %dPhi dx for extensometer


%Performing a linear regression
%Machine
coeff400_machine = polyfit(dPhi_dx400_machine, torque400, 1); %The slope is GJ

%Extensometer
coeff400_ext = polyfit(dPhi_dx400_ext, torque400, 1); %The slope is GJ

Gj_ctw_ext = coeff400_ext(1);
Gj_ctw_machine = coeff400_machine(1);


%% Plotting Closed Thin Wall
%Plotting torque over the shear strain for the extensometer
set(0, 'defaulttextinterpreter', 'latex');
figure();
plot(shear400_ext, torque400, 'linewidth', 2);
hold on
plot(shear400_machine, torque400, 'linewidth', 2);

title('Torque vs Shear Strain CTW');
xlabel('Shear Strain $$(rad)$$');
ylabel('Torque $$in \cdot lbf$$');
legend('Extensometer', 'Machine', 'location', 'nw', 'interpreter', 'latex');


%Plotting torque vs dPhi dx, the slope will be equal to Gj
figure();
plot(dPhi_dx400_ext, torque400, 'linewidth', 2); %extensometer
hold on
plot(dPhi_dx400_machine, torque400, 'linewidth', 2); %Machine

%Also plotting the linear fits for each set
x400_machine = linspace(-9e-3, 1e-3);
y400_machine = polyval(coeff400_machine, x400_machine);
x400_ext = linspace(-9e-3, 1e-3);
y400_ext = polyval(coeff400_ext, x400_ext);
plot(x400_ext, y400_ext, '--', 'color', 'b');
plot(x400_machine,y400_machine, '--', 'color', 'r'); %The linear regression


title('Torque vs $$\frac{d\phi}{dx}$$ CTW');
xlabel('$$\frac{d\phi}{dx}$$  $$(\frac{rad}{m})$$');
ylabel('Torque $$in \cdot lbf$$');
legend('Extensometer', 'Machine', 'Linear Fit', 'Linear Fit', 'location', 'nw', 'interpreter', 'latex');


%% Plotting Open Thin Wall
figure();
plot(shear20_ext, torque20);
hold on
plot(shear20_machine, torque20);

title('Torque vs Shear Strain OTW');
xlabel('Shear Strain $$(rad)$$');
ylabel('Torque $$in \cdot lbf$$');
legend('Extensometer', 'Machine', 'location', 'nw', 'interpreter', 'latex');


%Plotting torque vs dPhi dx, the slope will be equal to Gj
figure();
plot(dPhi_dx20_ext, torque20); %extensometer
hold on
plot(dPhi_dx20_machine, torque20); %Machine

%Also plotting the linear fits for each set
x20_machine = linspace(-0.004, 0.0005);
y20_machine = polyval(coeff20_machine, x20_machine);
x20_ext = linspace(-0.04, 0.005);
y20_ext = polyval(coeff20_ext, x20_ext);
plot(x20_ext, y20_ext, '--', 'color', 'b');
plot(x20_machine,y20_machine, '--', 'color', 'r'); %The linear regression


title('Torque vs $$\frac{d\phi}{dx}$$ OTW');
xlabel('$$\frac{d\phi}{dx}$$  $$(\frac{rad}{m})$$');
ylabel('Torque $$in \cdot lbf$$');
legend('Extensometer', 'Machine', 'Linear Fit', 'Linear Fit', 'location', 'nw', 'interpreter', 'latex');


%Test
% figure();
% plot(linFitOTW_ext_x, linFitOTW_ext_y);
% hold on
% plot(x20_ext, y20_ext, '--');

%% Calculating the uncertainty
%OTW extensometer
linFitOTW_ext = polyval(coeff20_ext, dPhi_dx20_ext);
residualOTW_ext = torque20 - linFitOTW_ext;
percentDiffOTW_ext = residualOTW_ext ./ torque20;
percentMeanOTW_ext = mean(percentDiffOTW_ext);
stdOTW_ext = std(residualOTW_ext);

%OTW machine
linFitOTW_machine = polyval(coeff20_machine, dPhi_dx20_machine);
residualOTW_machine = torque20 - linFitOTW_machine;
percentDiffOTW_machine = residualOTW_machine ./ torque20;
percentMeanOTW_machine = mean(percentDiffOTW_machine);
stdOTW_machine = std(residualOTW_machine);

%CTW extensometer
linFitCTW_ext = polyval(coeff400_ext, dPhi_dx400_ext);
residualCTW_ext = torque400 - linFitCTW_ext;
percentDiffCTW_ext = residualCTW_ext ./ torque400;
percentMeanCTW_ext = mean(percentDiffCTW_ext);
stdCTW_ext = std(residualCTW_ext);

%CTW machine
linFitCTW_machine = polyval(coeff400_machine, dPhi_dx400_machine);
residualCTW_machine = torque400 - linFitCTW_machine;
percentDiffCTW_machine = residualCTW_machine ./ torque400;
percentMeanCTW_machine = mean(percentDiffCTW_machine);
stdCTW_machine = std(residualCTW_machine);






