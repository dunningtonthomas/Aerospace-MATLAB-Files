



dispVec = [0 -0.3703 -0.7407 -1.1110 -1.4814 -1.8517 ]; 
   
   loadVec = [0 44.4822 88.9644 133.4466 177.9288 222.4110 ];
   
   
L = 4;
E = 68.9 * 10^9;
I = 2.47559 * 10^-6;
dBeam = -(loadVec .* L^3) ./ ( 48 * E * I);

dBeam = dBeam * 1000;

resids = dispVec - dBeam;

figure();
set(0, 'defaulttextinterpreter', 'latex');
hold on
plot(loadVec , dispVec, 'linewidth', 2)
plot(loadVec, dBeam, 'linewidth', 2)
yline(-1.8517 , "--")
yline(-1.7386 , "--")
legend("ANSYS Displacement" , "Equivalent Beam Model Displacement")
ylabel("Displacement(mm)")
xlabel("Applied Force(N)")
title('Beam Model');
hold off


%Plotting the residuals
figure();
plot(loadVec, resids, 'linewidth', 2);

ylabel("Beam Model and ANSYS Residuals (mm)")
xlabel("Applied Force (N)")
title('Residuals');


