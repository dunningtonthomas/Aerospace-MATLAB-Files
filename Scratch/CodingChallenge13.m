%clear; close; clc;

Temp=[-56 15 -24 -56 17 -56]; %Temperature 
VehicleSpeed=[559.5 340.3 78.2 212.3 1743.5 262.5];%Vehicle Speed
R=287; %Gas constant of air
y=1.4;%Heat Ratio of air

%Prealloication For Arrays
TempK=zeros(1,6); 
M=zeros(1,6);

for i=1:6
    TempK(i)=Temp(i)+273.15; %Changing Calculation to Kelvin
    M(i) = VehicleSpeed(i)/sqrt(y*R*TempK(i)); %Calculating Mach Number
   
end

%Outputing Vehicle Number and the Mach Number and Flow Regime
for i=1:6
 if M(i)<0.3
        fprintf('Vehicle %d Mach number is %f which is Low-speed, incompressible\n', i,M(i))
 elseif M(i)>=0.3 && M(i)<0.8
        fprintf('Vehicle %d Mach number is %f which is Subsonic\n', i,M(i))
 elseif 0.8<=M(i) && M(i)<1.2
      if 0.99<=M(i) && M(i)<=1.01
        fprintf('Vehicle %d Mach number is %f which is Sonic\n', i,M(i))
      else 
      fprintf('Vehicle %d Mach number is %f which is Transonic\n', i,M(i))
      end
 elseif 1.2 <= M(i) && M(i) < 5
     fprintf('Vehicle %d Mach number is %f which is Supersonic\n', i,M(i))
 else
     fprintf('Vehicle %d Mach number is %f which is Hypersonic\n', i,M(i))
 end
end

