%% Clean Up
clear; close all; clc;


%% Problem 2
Amat = [-0.02, 0.016, -0.65, -32.17; -0.13, -1.019, 454.21, 0; 0, -0.005, -1.38, 0; 0, 0, 1, 0];

[eigenVectors, eigenValues] = eig(Amat);

dampVals = damp(eigenValues);

%Normalizing eigenvectors
for i = 1:length(eigenVectors(:,1))
    eigenVectors(:,i) = eigenVectors(:,i) / eigenVectors(4,i);    
end

%Non-dimensionalize u and w
eigenVectors(1,:) = eigenVectors(1,:) / 502;
eigenVectors(2,:) = eigenVectors(2,:) / 502;



%Problem 2 second part
Amat2 = [0, 0, 1, 0, 0, 0; 0, 0, 0, 1, 0, 0; 0, 0, -0.02, 0.016, -0.65, -32.17;
    0, 0, -0.13, -1.019, 454.21, 0; 0, 0, 0, -0.005, -1.38, 0;
    0, 0, 0, 0, 1, 0];

[eigenVec2, eigenVal2] = eig(Amat2);

%% Problem 4

A4 = [-1.019, 454.21; -0.005, -1.38];

[eigVec4, eigVal4] = eig(A4);

damp(eigVal4)

k1 = -5;
k2 = -0.005;
u0 = 502;

% BkMat = [-1.46; -0.2]*[0 0 -k1 -k2];
% 
% AnewMat = A4 + BkMat;


%New eigs
% [eigControlVec, eigControlVal] = eig(AnewMat);



%% Problem 4 next part
%Calculate the full eigenvalues of the whole closed loop space

BkMat2 = [-0.244; -1.46; -0.2; 0] * [0, 0, -k1, -k2];

AmatFinal = Amat + BkMat2;

[eigFinalVec, eigFinalVal] = eig(AmatFinal);



%% Problem 5

A5 = [-0.045, 0.036, 0, -32.2; -0.369, -2.02, 176, 0; 0.0019, -0.0396, -2.948, 0; 0, 0, 1, 0];

[eigVec5, eigVal5] = eig(A5);


damp(eigVal5)



%% Creating a phasor plot
figure();
set(0, 'defaulttextinterpreter', 'latex');
scatter(real(eigenVectors(1,1)), imag(eigenVectors(1,1)), 'markerfacecolor', 'r', 'markeredgecolor', 'r');
hold on
grid on
scatter(real(eigenVectors(2,1)), imag(eigenVectors(2,1)), 'markerfacecolor', 'g', 'markeredgecolor', 'g');
scatter(real(eigenVectors(3,1)), imag(eigenVectors(3,1)), 'markerfacecolor', 'm', 'markeredgecolor', 'm');
scatter(real(eigenVectors(4,1)), imag(eigenVectors(4,1)), 'markerfacecolor', 'b', 'markeredgecolor', 'b');

plot([0, real(eigenVectors(1,1))], [0, imag(eigenVectors(1,1))], 'k');
plot([0, real(eigenVectors(2,1))], [0, imag(eigenVectors(2,1))], 'k');
plot([0, real(eigenVectors(3,1))], [0, imag(eigenVectors(3,1))], 'k');
plot([0, real(eigenVectors(4,1))], [0, imag(eigenVectors(4,1))], 'k');

title('Phasor Plot Short Period');
xlabel('Real');
ylabel('Imag');
legend('$\Delta \hat{u}$', '$\Delta \hat{w}$', '$\Delta q$', '$ \Delta \theta $', 'Interpreter','latex', 'FontSize', 14);


%Phugoid mode
figure();
scatter(real(eigenVectors(1,3)), imag(eigenVectors(1,3)), 'markerfacecolor', 'r', 'markeredgecolor', 'r');
hold on
grid on
scatter(real(eigenVectors(2,3)), imag(eigenVectors(2,3)), 'markerfacecolor', 'g', 'markeredgecolor', 'g');
scatter(real(eigenVectors(3,3)), imag(eigenVectors(3,3)), 'markerfacecolor', 'm', 'markeredgecolor', 'm');
scatter(real(eigenVectors(4,3)), imag(eigenVectors(4,3)), 'markerfacecolor', 'b', 'markeredgecolor', 'b');

plot([0, real(eigenVectors(1,3))], [0, imag(eigenVectors(1,3))], 'k');
plot([0, real(eigenVectors(2,3))], [0, imag(eigenVectors(2,3))], 'k');
plot([0, real(eigenVectors(3,3))], [0, imag(eigenVectors(3,3))], 'k');
plot([0, real(eigenVectors(4,3))], [0, imag(eigenVectors(4,3))], 'k');

title('Phasor Plot Phugoid');
xlabel('Real');
ylabel('Imag');
legend('$\Delta \hat{u}$', '$\Delta \hat{w}$', '$\Delta q$', '$ \Delta \theta $', 'Interpreter','latex', 'FontSize', 14);




