function [c_l,c_dw] = DiamondAirfoil(M, alpha, epsilon1, epsilon2)
%AUTHOR: Thomas Dunnington
%COLLABORATORS: Nolan Stevenson, Owen Craig, Carson Kohlbrenner, Chase Rupprecht
%DATE: 4/26/2023
%DIAMONDAIRFOIL 
%SUMMARY: This function uses shock expansion theory to calculate the
%coefficient of lift and wave drag for a diamond airfoil with given angles
%INPUTS:
%   M = freestream mach number
%   alpha = angle of attack
%   epsilon1 = leading edge angle of diamond airfoil
%   epsilon2 = trailing edge angle of diamond airfoil
%OUTPUTS:
%   c_l = coefficient of lift
%   c_dw = coefficient of drag (wave drag)
%REGION NOMENCLATURE:
%     (A)/\(C)
%  (1)  /  \
%       \  / 
%     (B)\/(D)


%Test if the airfoil creates a bow shock
maxAngle = abs(alpha) + epsilon1; %Maximum angle to produce a shock
[Betad] = ObliqueShockBeta(M,maxAngle,1.4,'Weak');

if(imag(Betad) ~= 0 || Betad < 0) %Condition for bow shock
    c_l = 0xDEADBEEF; %Return error code
    c_dw = 0xDEADBEEF;
    return;
end

%Calculate the static upstream pressure over the stagnation pressure
[~,~,p1oP01,~,~] = flowisentropic(1.4,M, 'mach');


%Conditions for fan on the top surface and shock on bottom
if(alpha - epsilon1 > 0)
    %%%%REGION A
    %Compute fan on top surface Region A
    [~,nu1,~] = flowprandtlmeyer(1.4,M); 
    nuA = nu1 + (alpha - epsilon1);

    %Get mach number after the fan
    [MA,~,~] = flowprandtlmeyer(1.4,nuA,'nu');

    %Use isentropic relations to get the pressure in region A
    [~,~,pAoP01,~,~] = flowisentropic(1.4,MA, 'mach');

    %Solve for pAoP1
    pAoP1 = pAoP01 / p1oP01;

    %%%%REGION B
    %Find the shock in region B
    Thetad = alpha + epsilon1;
    [Betad] = ObliqueShockBeta(M,Thetad,1.4,'Weak');

    %Normal component
    Mn = M * sind(Betad);

    %Call the normal shock equation
    %pBoP1 is the static pressure ratio
    %p0BoP01 is the total pressure ratio to be used in the next expansion
    %fan
    [~,~,pBoP1,~,MBn,p0BoP01,~] = flownormalshock(1.4,Mn,'mach');

    %Find MB
    MB = MBn / sind(Betad - Thetad);

    %%%%REGION C
    %Expansion fan turned by epsilon1 + epsilon2
    [~,nuA,~] = flowprandtlmeyer(1.4,MA); 
    nuC = nuA + (epsilon1 + epsilon2);

    %Get mach number after the fan
    [MC,~,~] = flowprandtlmeyer(1.4,nuC,'nu');

    %Use isentropic relations to get the pressure in region C
    [~,~,pCoP01,~,~] = flowisentropic(1.4,MC, 'mach');

    %Solve for static pressure ratio
    pCoP1 = pCoP01 / p1oP01;

    %%%%REGION D
    %Expansion fan turned by epsilon1 + epsilon2
    [~,nuB,~] = flowprandtlmeyer(1.4,MB); 
    nuD = nuB + (epsilon1 + epsilon2);

    %Get mach number after the fan
    [MD,~,~] = flowprandtlmeyer(1.4,nuD,'nu');

    %Use isentropic relations to get the pressure in region D
    [~,~,pDoP0B,~,~] = flowisentropic(1.4,MD, 'mach');
    pDoP01 = pDoP0B * p0BoP01; %Pressure in region D relative to freestream stagnation pressure

    %Solve for pressure relative to freestream static pressure
    pDoP1 = pDoP01 / p1oP01;

elseif(-alpha - epsilon1 > 0) %Condition for fan on bottom and shock on top

    %%%%REGION A
    %Compute shock on top surface Region A
    Thetad = -alpha + epsilon1;
    [Betad] = ObliqueShockBeta(M,Thetad,1.4,'Weak');

    %Normal component
    Mn = M * sind(Betad);

    %Call the normal shock equation
    [~,~,pAoP1,~,MAn,p0AoP01,~] = flownormalshock(1.4,Mn,'mach');

    %Find MB
    MA = MAn / sind(Betad - Thetad);

    %%%%REGION B
    [~,nu1,~] = flowprandtlmeyer(1.4,M); 
    nuB = nu1 + (-alpha - epsilon1);

    %Get mach number after the fan
    [MB,~,~] = flowprandtlmeyer(1.4,nuB,'nu');

    %Use isentropic relations to get the pressure in region B
    [~,~,pBoP01,~,~] = flowisentropic(1.4,MB, 'mach');

    %Solve for pressure relative to freestream static pressure
    pBoP1 = pBoP01 / p1oP01;

    %%%%REGION C
    %Expansion fan turned by epsilon1 + epsilon2
    [~,nuA,~] = flowprandtlmeyer(1.4,MA); 
    nuC = nuA + (epsilon1 + epsilon2);

    %Get mach number after the fan
    [MC,~,~] = flowprandtlmeyer(1.4,nuC,'nu');

    %Use isentropic relations to get the pressure in region C
    [~,~,pCoP0A,~,~] = flowisentropic(1.4,MC, 'mach');
    pCoP01 = pCoP0A * p0AoP01; %Get relative to freestream stag pressure

    %Solve for pressure relative to freestream static
    pCoP1 = pCoP01 / p1oP01;

    %%%%REGION D
    %Expansion fan turned by epsilon1 + epsilon2
    [~,nuB,~] = flowprandtlmeyer(1.4,MB); 
    nuD = nuB + (epsilon1 + epsilon2);

    %Get mach number after the fan
    [MD,~,~] = flowprandtlmeyer(1.4,nuD,'nu');

    %Use isentropic relations to get the pressure in region D
    [~,~,pDoP01,~,~] = flowisentropic(1.4,MD, 'mach');

    %Solve for pressure relative to freestream static
    pDoP1 = pDoP01 / p1oP01;

else %Shock on top and bottom
    %Conditions for no fan or shock when alpha == epsilon
    if(alpha == epsilon1)
        %%%%REGION A
        pAoP1 = 1;
        MA = M;
        p0AoP01 = 1;

        %%%%REGION B
        %Find the shock in region B
        Thetad = alpha + epsilon1;
        [Betad] = ObliqueShockBeta(M,Thetad,1.4,'Weak');
    
        %Normal component
        Mn = M * sind(Betad);
    
        %Call the normal shock equation
        [~,~,pBoP1,~,MBn,p0BoP01,~] = flownormalshock(1.4,Mn,'mach');
    
        %Find MB
        MB = MBn / sind(Betad - Thetad);

    elseif(-alpha == epsilon1)
        %%%%REGION A
        %Compute shock on top surface Region A
        Thetad = epsilon1 - alpha;
        [Betad] = ObliqueShockBeta(M,Thetad,1.4,'Weak');
    
        %Normal component
        Mn = M * sind(Betad);
    
        %Call the normal shock equation
        [~,~,pAoP1,~,MAn,p0AoP01,~] = flownormalshock(1.4,Mn,'mach');
    
        %Find MA
        MA = MAn / sind(Betad - Thetad);

        %%%%REGION B
        pBoP1 = 1;
        MB = M;
        p0BoP01 = 1;

    else %Case where there is a shock in region A and B
        %%%%REGION A
        %Compute shock on top surface Region A
        Thetad = epsilon1 - alpha;
        [Betad] = ObliqueShockBeta(M,Thetad,1.4,'Weak');
    
        %Normal component
        Mn = M * sind(Betad);
    
        %Call the normal shock equation
        [~,~,pAoP1,~,MAn,p0AoP01,~] = flownormalshock(1.4,Mn,'mach');
    
        %Find MA
        MA = MAn / sind(Betad - Thetad);

        %%%%REGION B
        %Find the shock in region B
        Thetad = alpha + epsilon1;
        [Betad] = ObliqueShockBeta(M,Thetad,1.4,'Weak');
    
        %Normal component
        Mn = M * sind(Betad);
    
        %Call the normal shock equation
        [~,~,pBoP1,~,MBn,p0BoP01,~] = flownormalshock(1.4,Mn,'mach');
    
        %Find MB
        MB = MBn / sind(Betad - Thetad);
    end

    %%%%REGION C
    %Expansion fan turned by epsilon1 + epsilon2
    [~,nuA,~] = flowprandtlmeyer(1.4,MA); 
    nuC = nuA + (epsilon1 + epsilon2);

    %Get mach number after the fan
    [MC,~,~] = flowprandtlmeyer(1.4,nuC,'nu');

    %Use isentropic relations to get the pressure in region C
    [~,~,pCoP0A,~,~] = flowisentropic(1.4,MC, 'mach');
    pCoP01 = pCoP0A * p0AoP01;

    %Pressure relative to freestream static
    pCoP1 = pCoP01 / p1oP01;

    %%%%REGION D
    %Expansion fan turned by epsilon1 + epsilon2
    [~,nuB,~] = flowprandtlmeyer(1.4,MB); 
    nuD = nuB + (epsilon1 + epsilon2);

    %Get mach number after the fan
    [MD,~,~] = flowprandtlmeyer(1.4,nuD,'nu');

    %Use isentropic relations to get the pressure in region D
    [~,~,pDoP0B,~,~] = flowisentropic(1.4,MD, 'mach');
    pDoP01 = pDoP0B * p0BoP01;
    pDoP1 = pDoP01 / p1oP01;
end


%Calculate the coefficient of lift and drag using the pressures
%Define length 1 over c and length 2 over c using law of sines
L1oC = sind(epsilon2) / sind(180 - epsilon1 - epsilon2);
L2oC = sind(epsilon1) / sind(180 - epsilon1 - epsilon2);


%Coefficent calculations
c_l = 1 / (1.4 / 2 * M^2) * (pBoP1*L1oC*cosd(epsilon1 + alpha) + pDoP1*L2oC*cosd(alpha - epsilon2) - pAoP1*L1oC*cosd(alpha - epsilon1) - pCoP1*L2oC*cosd(alpha + epsilon2));
c_dw = 1 / (1.4 / 2 * M^2) * (pBoP1*L1oC*sind(epsilon1 + alpha) + pDoP1*L2oC*sind(alpha - epsilon2) - pAoP1*L1oC*sind(alpha - epsilon1) - pCoP1*L2oC*sind(alpha + epsilon2));

end

