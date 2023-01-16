function PlotAircraftSim(TOUT, aircraft_state, control_surfaces, background_wind_array, col)


%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
 
subplot(311);
plot(TOUT, aircraft_state(:,1),col, 'linewidth', 2);
hold on;
title('Position v Time');   
ylabel('X [m]')    

subplot(312);
plot(TOUT, aircraft_state(:,2),col, 'linewidth', 2);hold on;
 ylabel('Y [m]')    
 
subplot(313);
plot(TOUT, aircraft_state(:,3),col, 'linewidth', 2);hold on;
ylabel('Z [m]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
 
subplot(311);
plot(TOUT, (180/pi)*aircraft_state(:,4),col, 'linewidth', 2);hold on;
title('Euler Angles v Time');   
ylabel('Roll [deg]')    

subplot(312);
plot(TOUT, (180/pi)*aircraft_state(:,5),col, 'linewidth', 2);hold on;
 ylabel('Pitch [deg]')    
 
subplot(313);
plot(TOUT, (180/pi)*aircraft_state(:,6),col, 'linewidth', 2);hold on;
ylabel('Yaw [deg]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
 
subplot(311);
plot(TOUT, aircraft_state(:,7),col, 'linewidth', 2);hold on;
title('Velocity v Time');   
ylabel('uE [m/s]')    

subplot(312);
plot(TOUT, aircraft_state(:,8),col, 'linewidth', 2);hold on;
 ylabel('vE [m/s]')    
 
subplot(313);
plot(TOUT, aircraft_state(:,9),col, 'linewidth', 2);hold on;
ylabel('wE [m/s]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(4);
 
subplot(311);
plot(TOUT, (180/pi)*aircraft_state(:,10),col, 'linewidth', 2);hold on;
title('Angular Velocity v Time');   
ylabel('p [deg/s]')    

subplot(312);
plot(TOUT, (180/pi)*aircraft_state(:,11),col, 'linewidth', 2);hold on;
 ylabel('q [deg/s]')    
 
subplot(313);
plot(TOUT, (180/pi)*aircraft_state(:,12),col, 'linewidth', 2);hold on;
ylabel('r [deg/s]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(5);
plot3(aircraft_state(:,1),aircraft_state(:,2),-aircraft_state(:,3),col, 'linewidth', 2);hold on;


%%%%%%%%%%%%%%%%%%%%%%%%
if (~isempty(control_surfaces))
    figure(6);
    
    subplot(411);
    plot(TOUT, control_surfaces(:,1),col, 'linewidth', 2);hold on;
    title('Control Surfaces v Time');   
    ylabel('Elevator [rad]')    

    subplot(412);
    plot(TOUT, control_surfaces(:,2),col, 'linewidth', 2);hold on;
    ylabel('Aileron [rad]')      
 
    subplot(413);
    plot(TOUT, control_surfaces(:,3),col, 'linewidth', 2);hold on;
    ylabel('Rudder [rad]')       
    
    subplot(414);
    plot(TOUT, control_surfaces(:,4),col, 'linewidth', 2);hold on;
    ylabel('Throttle [frac]')     
    xlabel('time [sec]');

end


%%%%%%%%%%%%%%
%Getting the wind angles over time
inertVels = aircraft_state(:,7:9);
eulerAngles = aircraft_state(:,4:6);

%Creating variables for the wind angles
Vvec = zeros(length(inertVels(:,1)),1);
betaVec = zeros(length(inertVels(:,1)),1);
alphaVec = zeros(length(inertVels(:,1)),1);


%Calculating the wind from the inertial velocities
for i = 1:length(inertVels(:,1))
    inertVel = inertVels(i,:);
    angles = eulerAngles(i,:);
    inertWind = TransformFromInertialToBody(background_wind_array, angles);
    airRelVel = inertVel' - inertWind;
    windAngles = WindAnglesFromVelocityBody(airRelVel);    
    Vvec(i) = windAngles(1);
    betaVec(i) = windAngles(2);
    alphaVec(i) = windAngles(3);
end

figure(7);
subplot(3,1,1);
plot(TOUT, Vvec, col, 'linewidth', 2);
hold on;

ylabel('Wind Velocity (m/s)');
title('Wind Angles Over Time');

subplot(3,1,2);
plot(TOUT, betaVec, col, 'linewidth', 2);
hold on;

ylabel('Sideslide Angle (rad)');

subplot(3,1,3);
plot(TOUT, alphaVec, col, 'linewidth', 2);
hold on;

ylabel('Angle of Attack (rad)');


xlabel('Time (s)');









