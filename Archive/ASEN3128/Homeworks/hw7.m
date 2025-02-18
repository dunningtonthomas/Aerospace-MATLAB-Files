%% Clean Up
clear; close all; clc;


%% Prelim Data
Alat = [-0.0561 0 -775.0000 32.2000;
-0.0038 -0.4138 0.4231 0;
0.0011 -0.0064 -0.1456 0;
0 1.0000 0 0];

Blat = [0 5.601;
-0.14120 0.1201;
0.00375 -0.4898;
0 0];


u0 = 775;
theta0 = atan(Alat(4,3));

AlatFull = [-0.0561 0 -775.0000 32.2000, 0, 0;
-0.0038 -0.4138 0.4231 0, 0, 0;
0.0011 -0.0064 -0.1456 0, 0, 0;
0 1.0000 0 0, 0, 0;
0, 0, 1/cos(theta0), 0, 0, 0;
1, 0, 0, 0, u0*cos(theta0), 0];


BlatFull = [0 5.601;
-0.14120 0.1201;
0.00375 -0.4898;
0 0;
0, 0;
0, 0];



%% Problem
Yv = Alat(1,1);
Nv = Alat(3,1);
Nr = Alat(3,3);
u0 = 775;

dutchApprox = [Yv, -u0; Nv, Nr];



%% Problem 3

D = zeros(4,1);

[num, den] = ss2tf(Alat, Blat(:,2), [1/u0, 0, 0, 0] , 0);

transFunc = tf(num, den);

step(2*transFunc);

roots(den);

% damp(transFunc);

%% Problem 4
[eigVec, eigVals] = eig(AlatFull);

kr = -2;
kmat = [0, 0, 0, 0, 0, 0; 0, 0, kr, 0, 0, 0];

AFinal = AlatFull - BlatFull*kmat;

[eigVec, eigVals] = eig(AFinal);


lateralPhugoid = eigVec(:,5);
dutch = eigVec(:,3);

%Get the y in hundreds of feet
lateralPhugoid(6,1) = lateralPhugoid(6,1) / 100;
dutch(6,1) = dutch(6,1) / 100;

%Get the v to beta
lateralPhugoid(1,1) = lateralPhugoid(1,1) / 775;
dutch(1,1) = dutch(1,1) / 775;

%Normalize with respect to psi so it is 0.1 radians
lateralPhugoid = lateralPhugoid / lateralPhugoid(5) * 0.1;
dutch = dutch / dutch(5) * 0.1;

lateralPReal = real(lateralPhugoid);
dutchReal = real(dutch);

lateralPImag = imag(lateralPhugoid);
dutchImag = imag(dutch);


%Plot the phasor plots
figure();
plot([0,dutchReal(1)], [0, dutchImag(1)]);
hold on
plot([0,dutchReal(2)], [0, dutchImag(2)]);
plot([0,dutchReal(3)], [0, dutchImag(3)]);
plot([0,dutchReal(4)], [0, dutchImag(4)]);
plot([0,dutchReal(5)], [0, dutchImag(5)]);
plot([0,dutchReal(6)], [0, dutchImag(6)]);


%Lateral Phugoid
figure();
plot([0,lateralPReal(1)], [0, lateralPImag(1)]);
hold on
plot([0,lateralPReal(2)], [0, lateralPImag(2)]);
plot([0,lateralPReal(3)], [0, lateralPImag(3)]);
plot([0,lateralPReal(4)], [0, lateralPImag(4)]);
plot([0,lateralPReal(5)], [0, lateralPImag(5)]);
plot([0,lateralPReal(6)], [0, lateralPImag(6)]);




%% Creating a phasor plot
figure();
set(0, 'defaulttextinterpreter', 'latex');
scatter(dutchReal(1), dutchImag(1), 'markerfacecolor', 'r', 'markeredgecolor', 'r');
hold on
grid on
scatter(dutchReal(2), dutchImag(2), 'markerfacecolor', 'g', 'markeredgecolor', 'g');
scatter(dutchReal(3), dutchImag(3), 'markerfacecolor', 'm', 'markeredgecolor', 'm');
scatter(dutchReal(4), dutchImag(4), 'markerfacecolor', 'b', 'markeredgecolor', 'b');
scatter(dutchReal(5), dutchImag(5), 'markerfacecolor', 'c', 'markeredgecolor', 'c');
scatter(dutchReal(6), dutchImag(6), 'markerfacecolor', 'k', 'markeredgecolor', 'k');

plot([0, dutchReal(1)], [0, dutchImag(1)], 'k');
plot([0, dutchReal(2)], [0, dutchImag(2)], 'k');
plot([0, dutchReal(3)], [0, dutchImag(3)], 'k');
plot([0, dutchReal(4)], [0, dutchImag(4)], 'k');
plot([0, dutchReal(5)], [0, dutchImag(5)], 'k');
plot([0, dutchReal(6)], [0, dutchImag(6)], 'k');



title('Phasor Plot Dutch Roll Mode');
xlabel('Real');
ylabel('Imag');
legend('$\Delta \beta$', '$\Delta p$', '$\Delta r$', '$ \Delta \phi $', '$ \Delta \psi $', '$ \Delta y_{E} $', 'Interpreter','latex', 'FontSize', 14, 'location', 'best');


%Lateral Phugoid
figure();
set(0, 'defaulttextinterpreter', 'latex');
scatter(lateralPReal(1), lateralPImag(1), 'markerfacecolor', 'r', 'markeredgecolor', 'r');
hold on
grid on
scatter(lateralPReal(2), lateralPImag(2), 'markerfacecolor', 'g', 'markeredgecolor', 'g');
scatter(lateralPReal(3), lateralPImag(3), 'markerfacecolor', 'm', 'markeredgecolor', 'm');
scatter(lateralPReal(4), lateralPImag(4), 'markerfacecolor', 'b', 'markeredgecolor', 'b');
scatter(lateralPReal(5), lateralPImag(5), 'markerfacecolor', 'c', 'markeredgecolor', 'c');
scatter(lateralPReal(6), lateralPImag(6), 'markerfacecolor', 'k', 'markeredgecolor', 'k');

plot([0, lateralPReal(1)], [0, lateralPImag(1)], 'k');
plot([0, lateralPReal(2)], [0, lateralPImag(2)], 'k');
plot([0, lateralPReal(3)], [0, lateralPImag(3)], 'k');
plot([0, lateralPReal(4)], [0, lateralPImag(4)], 'k');
plot([0, lateralPReal(5)], [0, lateralPImag(5)], 'k');
plot([0, lateralPReal(6)], [0, lateralPImag(6)], 'k');

title('Phasor Plot Lateral Phugoid Mode');
xlabel('Real');
ylabel('Imag');
legend('$\Delta \beta$', '$\Delta p$', '$\Delta r$', '$ \Delta \phi $', '$ \Delta \psi $', '$ \Delta y_{E} $', 'Interpreter','latex', 'FontSize', 14, 'location', 'best');
