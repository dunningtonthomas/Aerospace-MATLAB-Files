%% ASEN 3112 Lab 3
% Max Feinland
% Created: 11/16
% Last modified: 

% Constants
L = 12; % in
w = 1; % in
h = 1/8; % in
E = 1.0175e+7; % psi
rho = 0.0002505; % lb s^2/in^4

% values given at the end of the doc
A = w*h;
Izz = w*h^3/13;
cm2 = rho*A*L/100800;
cm4 = rho*A*L/806400;
ck2 = 4*E*Izz/L^3;
ck4 = 8*E*Izz/L^3;
m_t = 1.131*rho;
s_t = 0.5655*rho;
i_t = 23.124*rho;

%% Matrices
% mass matrix for 2-element beam
M2 = cm2*[19272 1458*L 5928 -642*L 0 0; ...
    1458*L 172*L^2 642*L -73*L^2 0 0; ...
    5928 642*L 38544 0 5928 -642*L; ...
    -642*L -73*L^2 0 344*L^2 642*L -73*L^2; ...
    0 0 5928 642*L 19272 -1458*L; ...
    0 0  -642*L -73*L^2 -1458*L 172*L^2] + ...
    [0 0 0 0 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0; ...
    0 0 0 0 0 0; 0 0 0 0 m_t s_t; 0 0 0 0 s_t i_t];

% stiffness matrix for 2-element beam
K2 = ck2*[24 6*L -24 6*L 0 0; ...
    6*L 2*L^2 -6*L L^2 0 0; ....
    -24 -6*L 48 0 -24 6*L;
    6*L L^2 0 4*L^2 -6*L L^2;
    0 0 -24 -6*L 24 -6*L; ...
    0 0 6*L L^2 -6*L 2*L^2];

% removing first two rows and columns
M2 = M2(3:6, 3:6);
K2 = K2(3:6, 3:6);

% mass matrix for 4-element beam
M4 = cm4*[77088 2916*L 23712 -1284*L 0 0 0 0 0 0; ...
    2916*L 172*L^2 1284*L -73*L^2 0 0 0 0 0 0; ...
    23712 1284*L 154176 0 23712 -1284*L 0 0 0 0; ...
    -1284*L -73*L^2 0 344*L^2 1284*L -73*L^2 0 0 0 0; ...
    0 0 23712 1284*L 154176 0  23712 -1284*L 0 0; ...
    0 0 -1284*L -73*L^2 0 344*L^3 1284*L -73*L^2 0 0;
    0 0 0 0 23712 1284*L 154176 0 23712 -1284*L;
    0 0 0 0 -1284*L -73*L^2 0 344*L^2 1284*L -73*L^2; ...
    0 0 0 0 0 0 23712 1284*L 77088 -2916*L; ...
    0 0 0 0 0 0 -1284*L -73*L^2 -2916*L 172*L^2] + ...
    [0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0; ...
    0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0; ...
    0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0; ...
    0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0; ...
    0 0 0 0 0 0 0 0 m_t s_t; 0 0 0 0 0 0 0 0 s_t i_t];

K4 = ck4*[96 12*L -96 12*L 0 0 0 0 0 0; ...
    12*L 2*L^2 -12*L L^2 0 0 0 0 0 0; ...
    -96 -12*L 192 0 -96 12*L 0 0 0 0; ...
    12*L L^2 0  4*L^2 -12*L L^2 0 0 0 0; ...
    0 0 -96 -12*L 192 0 -96 12*L 0 0; ...
    0 0 12*L L^2 0 4*L^2 -12*L L^2 0 0; ...
    0 0 0 0 -96 -12*L 192 0 -96 12*L; ...
    0 0 0 0 12*L L^2 0 4*L^2 -12*L L^2; ...
    0 0 0 0 0 0 -96 -12*L 96 -12*L; ...
    0 0 0 0 0 0 12*L L^2 -12*L 2*L^2];

M4 = M4(3:10, 3:10);
K4 = K4(3:10, 3:10);


%% Eigenvalues/vectors
% eigenvalues and eigenvectors
[v2, d2] = eig(K2, M2);

% natural frequency
w2 = [sqrt(d2(1,1)) sqrt(d2(2,2)) sqrt(d2(3,3))];
f2 = w2/(2*pi);

% fprintf(['The three smallest frequencies for 2-element FEM are ' ...
%     ' %.2f, %.2f, and %.2f Hz.\n'], f2(1), f2(2), f2(3))
% fprintf(['The three smallest frequencies for 4-element FEM are ' ...
%     '%.2f, %.2f, and %.2f Hz.\n'], f4(1), f4(2), f4(3))

[v4, d4] = eig(K4, M4);

% natural frequency
w4 = [sqrt(d4(1,1)) sqrt(d4(2,2)) sqrt(d4(3,3))];
f4 = w4/(2*pi);

% modal shapes
v2_1 = v2(:,1)/max(v2(:,1));
v2_2 = v2(:,2)/max(v2(:,2));
v2_3 = v2(:,3)/max(v2(:,3));

v4_1 = v4(:,1)/min(v4(:,1));
v4_2 = v4(:,2)/min(v4(:,2));
v4_3 = v4(:,3)/min(v4(:,3));

load('ExperimentalShape.mat');
% plotting modal shapes
figure()
title('2-Element FEM')
hold on
ploteig(L, v2_1, 2, 30, 1, 1);
ploteig(L, -v2_2, 2, 30, 1, 2);
% ploteig(L, v2_3, 2, 30, 1, 3);



hold off
%title('2-Element FEM')

figure()
hold on
plot1 = ploteig(L, v4_1, 4, 30, 1, 1);
plot2 = ploteig(L, -v4_2, 4, 30, 1, 2);
hold off

%Plotting experimental data
figure(2)
subplot(2,1,1);
hold on
x = plot(distances, dispMode2, '*', 'color', 'r');
legend([plot1, x], 'FEM', 'Experimental', 'location', 'best');

figure(2)
subplot(2,1,2);
hold on
x = plot(distances, -dispMode5, '*', 'color', 'r');

legend([plot2, x], 'FEM', 'Experimental', 'location', 'best');

%% Functions
function [plotNum] = ploteig(L, ev, ne, nsub, scale, mode)
ev = [0; 0; ev];
nv = ne*nsub + 1; 
Le = L/ne; 
dx = Le/nsub; 
k = 1;
x = zeros(length(nv),1); % declare and set to zero plot arrays
v = zeros(length(nv),1);
for e = 1:ne % loop over elements
 xi(e) = Le*(e-1); 
 vi(e) = ev(2*e-1); 
 qi(e) = ev(2*e); 
 vj(e) = ev(2*e+1); 
 qj(e) = ev(2*e+2);
 for n = 1:nsub % loop over subdivisions
 xk(n) = xi(e) + dx*n; 
 x(n) = (2*n - nsub)/nsub; % isoP coordinate
 vk(n) = scale*(0.125*(4*(vi(e) + vj(e)) + 2*(vi(e) - vj(e))*(x(n)^2 - 3)*x(n) + ...
     Le*(x(n)^2 - 1)*(qj(e) - qi(e) + (qi(e) + qj(e))*x(n)))); % Hermitian interpolant
 k = k+1; 
 xw(k) = xk(n); 
 vw(k) = vk(n);
 end
end
subplot(2,1,mode)
plotNum = plot(xw,vw);
xlabel('Bar Length (in)')
ylabel('Deflection (in)')
title(['Beam Bending for ', num2str(ne), '-element FEM model, Mode ', num2str(mode)])
grid on
yline(0)
end
