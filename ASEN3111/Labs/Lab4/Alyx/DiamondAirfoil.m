%%%%%%%%%%%%% Diamond Airfoil function %%%%%%%%%%%%% 
% this function calculates the sectional lift and wave drag coefficients
% for an diamond airfoil. The  diamond airfoil is not symmetric and
% outlined in the lab document. The function uses the provided ObliqueShockBeta
% function as well as the flowisentropic, flownormalshock, and
% flowprandtlmeyer functions included in the aerospace toolbox. There are
% three cases and the calculations in each case use the same methodolgy.
% To verify the methodology and calculations, case 3 was tested by
% comparing the cl and cdw output to the problem 9.14 in Anderson. 

% Inputs: M - Mach Number, alpha - aoa, epsilon1- angle 1, epsilon2- angle2
% Outputs: c_1 -sectional lift coefficient, c_dw sectional wave drag coeff


function [c_l,c_dw] = DiamondAirfoil(M, alpha, epsilon1, epsilon2)

Gamma = 1.4; % gamma for air 
Type = 'Weak'; % weak solution is used for beta - theta - m

alpha = abs(alpha);
% P_0# variables are P0#/P#
% P_# variables are P#/P1

%% Case 1 0 <= epsilon1  && epsilon1 < alpha 
if 0 <= epsilon1  && epsilon1 < alpha 

    %------------- section 1-2 OS
    theta_1 = epsilon1;

    % Calling oblique shock function to determine beta
    beta_1 = ObliqueShockBeta(M,theta_1,Gamma,Type);
    
    % if statement for bow shockos
   if imag(beta_1) ~= 0 || beta_1 < 0
    
       c_l = NaN;
       c_dw = NaN;
       disp('Bow shock occurred')
       return
   end

    Mn1 = M*sind(beta_1); % normal component of M
    
    % Determining downstream mach and presssure ratios
    [~,~,P_2,~,Mn2,P_02,~] = flownormalshock(Gamma,Mn1,'mach');

    mach_2 = Mn2/(sind(beta_1-theta_1)); % OS mach
    

    [~,~,P_01,~,~] = flowisentropic(Gamma,M,'mach'); % p01/p1
    P_01 = 1/P_01;
    
    % pressure ratios are inverted when using the flowisentropic function


    % disp('Case 1 alpha < epsilon') used for debugging


%% Case 2 epsilon1 = alpha
elseif epsilon1 == alpha

    %------------- section 1-2 no turn, no wave drag
    P_2 = 1;
    
    mach_2 = M;
    [~,~,P_01,~,~] = flowisentropic(Gamma,M,'mach'); % p01/p1
    P_01 = 1/P_01;
    [~,~,P_02,~,~] = flowisentropic(Gamma,M,'mach'); % p01/p1
    P_02 = 1/P_02;
 

    %disp('Case 2 alpha = epsilon') used for debugging
    
    %% Case 3 epsilon1 < alpha
else

    %------------- section 1-2 PM expansion fan

    theta_2 =  alpha - epsilon1;
    [~,v_1,~] = flowprandtlmeyer(Gamma,M,'mach');
    v_2 = v_1 + theta_2;
    [mach_2,~,~] = flowprandtlmeyer(Gamma,v_2,'nu');
    [~,~,P_02,~,~] = flowisentropic(Gamma,mach_2,'mach'); % p02/p2
    P_02 = 1/P_02;

    [~,~,P_01,~,~] = flowisentropic(Gamma,M,'mach'); % p01/p1
    P_01 = 1/P_01;

    P_2 = (1/P_02)*P_01;

    % disp('Case 3 alpha > epsilon') used for debugging

end


%------------- section 2-3 PM expansion fan
    theta_3 = epsilon1 + epsilon2;
    [~,v_2,~] = flowprandtlmeyer(Gamma,mach_2,'mach'); % mach angle
    v_3 = v_2 + theta_3;
    [mach_3,~,~] = flowprandtlmeyer(Gamma,v_3,'nu');
    [~,~,P_03,~,~] = flowisentropic(Gamma,mach_3,'mach'); %p03/p3
    P_03 = 1/P_03;

    P_3 = P_2 * (1/P_03) * 1 * P_02;

 %------------- section 1-4 OS

    theta_4 = epsilon1 + alpha;

    % Calling oblique shock function to determine beta
    beta_4 = ObliqueShockBeta(M,theta_4,Gamma,Type);

    % if statement for bow shockos
   if imag(beta_4) ~= 0 || beta_4 < 0
    
       c_l = NaN;
       c_dw = NaN;
       disp('Bow shock occurred')
       return
   end

    Mn1 = M*sind(beta_4);% normal component of M

    % Determining downstream mach and presssure ratios
    [~,~,P_4,~,Mn4,P_04,~] = flownormalshock(Gamma,Mn1,'mach');

    mach_4 = Mn4/(sind(beta_4-theta_4));% OS mach
    
    [~,v_4,~] = flowprandtlmeyer(Gamma,mach_4,'mach'); % mach angle
    

%------------- section 4-5 PM expansion fan 
    theta_5 = epsilon1 + epsilon2 ;
    v_5 = v_4 + theta_5;
    [mach_5,~,~] = flowprandtlmeyer(Gamma,v_5,'nu');
    [~,~,P_05,~,~] = flowisentropic(Gamma,mach_5,'mach'); % p05/p5
    P_05 = 1/P_05;

    P_5 = (1/P_05) * 1 * P_04 * P_01;

    
% calculating cn and ca using similar derivation to diamondairfoil handout
c_n = (1/(1+(tand(epsilon1)/tand(epsilon2)))* (2/((M^2)*Gamma) * (-P_2 + P_4))) ...
        + (1/(1+(tand(epsilon2)/tand(epsilon1)))* (2/((M^2)*Gamma) * (-P_3 + P_5)));

c_a = (1/((1/tand(epsilon1))+ (1/tand(epsilon2)))) * (2/((M^2)*Gamma)) * (P_2 + P_4 - P_3 - P_5);

% using cn and ca to determine cl and cdw

c_l = c_n*cosd(alpha)- c_a*sind(alpha);
c_dw= c_n*sind(alpha)+ c_a*cosd(alpha);


if alpha < 0
    c_l = -c_1;
end



end