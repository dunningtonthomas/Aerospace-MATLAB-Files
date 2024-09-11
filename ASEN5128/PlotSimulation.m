function PlotSimulation(time, aircraft_state_array, control_input_array, col)
%PLOTSIMULATION Summary of this function goes here
%   Detailed explanation goes here

figure(1);
subplot(311);
plot(time, aircraft_state_array(:,1),col, 'linewidth', 2);
hold on;
title('Position v Time');   
ylabel('X [m]')    

subplot(312);
plot(time, aircraft_state_array(:,2),col, 'linewidth', 2);hold on;
 ylabel('Y [m]')    
 
subplot(313);
plot(time, aircraft_state_array(:,3),col, 'linewidth', 2);hold on;
ylabel('Z [m]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
 
subplot(311);
plot(time, (180/pi)*aircraft_state_array(:,4),col, 'linewidth', 2);hold on;
title('Euler Angles v Time');   
ylabel('Roll [deg]')    

subplot(312);
plot(time, (180/pi)*aircraft_state_array(:,5),col, 'linewidth', 2);hold on;
 ylabel('Pitch [deg]')    
 
subplot(313);
plot(time, (180/pi)*aircraft_state_array(:,6),col, 'linewidth', 2);hold on;
ylabel('Yaw [deg]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
 
subplot(311);
plot(time, aircraft_state_array(:,7),col, 'linewidth', 2);hold on;
title('Velocity v Time');   
ylabel('uE [m/s]')    

subplot(312);
plot(time, aircraft_state_array(:,8),col, 'linewidth', 2);hold on;
 ylabel('vE [m/s]')    
 
subplot(313);
plot(time, aircraft_state_array(:,9),col, 'linewidth', 2);hold on;
ylabel('wE [m/s]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(4);
 
subplot(311);
plot(time, (180/pi)*aircraft_state_array(:,10),col, 'linewidth', 2);hold on;
title('Angular Velocity v Time');   
ylabel('p [deg/s]')    

subplot(312);
plot(time, (180/pi)*aircraft_state_array(:,11),col, 'linewidth', 2);hold on;
 ylabel('q [deg/s]')    
 
subplot(313);
plot(time, (180/pi)*aircraft_state_array(:,12),col, 'linewidth', 2);hold on;
ylabel('r [deg/s]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(5);
plot3(aircraft_state_array(:,1),aircraft_state_array(:,2),-aircraft_state_array(:,3),col, 'linewidth', 2);hold on;


%%%%%%%%%%%%%%%%%%%%%%%%
if (~isempty(control_input_array))
    figure(6);
    
    subplot(411);
    plot(time, control_input_array(:,1),col, 'linewidth', 2);hold on;
    title('Control Surfaces v Time');   
    ylabel('Elevator [rad]')    

    subplot(412);
    plot(time, control_input_array(:,2),col, 'linewidth', 2);hold on;
    ylabel('Aileron [rad]')      
 
    subplot(413);
    plot(time, control_input_array(:,3),col, 'linewidth', 2);hold on;
    ylabel('Rudder [rad]')       
    
    subplot(414);
    plot(time, control_input_array(:,4),col, 'linewidth', 2);hold on;
    ylabel('Throttle [frac]')     
    xlabel('time [sec]');

end

end

