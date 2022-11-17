function PlotAircraftSim_Lab5(TOUT, aircraft_state, control_surfaces, wind_inertial, col)



len_sim = length(TOUT);
    
    
    for i = 1:len_sim
        [flight_angles] = FlightPathAnglesFromState(aircraft_state(i,:)');
        chi(i,1) = (180/pi)*flight_angles(2,1);
        gamma(i,1) = (180/pi)*flight_angles(3,1);
        
        wind_body = TransformFromInertialToBody(wind_inertial, aircraft_state(i,4:6)');
        air_rel_vel_body = aircraft_state(i,7:9)' - wind_body;

        wind_angles(:,i) = WindAnglesFromVelocityBody(air_rel_vel_body);
    end


    
    

%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
 
subplot(311);
h1= plot(TOUT, aircraft_state(:,1),col);hold on;
title('Position v Time');   
ylabel('X [m]')    

subplot(312);
plot(TOUT, aircraft_state(:,2),col);hold on;
 ylabel('Y [m]')    
 
subplot(313);
plot(TOUT, aircraft_state(:,3),col);hold on;
ylabel('Z [m]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
 
subplot(311);
plot(TOUT, (180/pi)*aircraft_state(:,4),col);hold on;
title('Euler Angles v Time');   
ylabel('Roll [deg]')    

subplot(312);
plot(TOUT, (180/pi)*aircraft_state(:,5),col);hold on;
 ylabel('Pitch [deg]')    
 
subplot(313);
plot(TOUT, (180/pi)*aircraft_state(:,6),col);hold on;
ylabel('Yaw [deg]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
 
subplot(311);
plot(TOUT, aircraft_state(:,7),col);hold on;
title('Velocity v Time');   
ylabel('uE [m/s]')    

subplot(312);
plot(TOUT, aircraft_state(:,8),col);hold on;
 ylabel('vE [m/s]')    
 
subplot(313);
plot(TOUT, aircraft_state(:,9),col);hold on;
ylabel('wE [m/s]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(4);
 
subplot(311);
plot(TOUT, (180/pi)*aircraft_state(:,10),col);hold on;
title('Angular Velocity v Time');   
ylabel('p [deg/s]')    

subplot(312);
plot(TOUT, (180/pi)*aircraft_state(:,11),col);hold on;
 ylabel('q [deg/s]')    
 
subplot(313);
plot(TOUT, (180/pi)*aircraft_state(:,12),col);hold on;
ylabel('r [deg/s]')    
xlabel('time [sec]');

%%%%%%%%%%%%%%%%%%%%%%%%
figure(5);
plot3(aircraft_state(:,1),aircraft_state(:,2),-aircraft_state(:,3),col);hold on;


%%%%%%%%%%%%%%%%%%%%%%%%
if (~isempty(control_surfaces))
    figure(6);
    
    subplot(411);
    plot(TOUT, control_surfaces(:,1)*(180/pi),col);hold on;
    title('Control Surfaces v Time');   
    ylabel('\delta_e [deg]')    

    subplot(412);
    plot(TOUT, control_surfaces(:,2)*(180/pi),col);hold on;
    ylabel('\delta_a [deg]')      
 
    subplot(413);
    plot(TOUT, control_surfaces(:,3)*(180/pi),col);hold on;
    ylabel('\delta_r [deg]')       
    
    subplot(414);
    plot(TOUT, control_surfaces(:,4),col);hold on;
    ylabel('\delta_t [frac]')     
    xlabel('time [sec]');

end

%%%%%%%%%%%%%%%%%%%%%%%%
figure(7);
 
subplot(311);
h7= plot(TOUT, wind_angles(1,:) ,col);hold on;
title('Wind Angles v Time');   
ylabel('V_a [m/s]')    

subplot(312);
plot(TOUT, (180/pi)*wind_angles(2,:),col);hold on;
 ylabel('\beta [deg]')    
 
subplot(313);
plot(TOUT, (180/pi)*wind_angles(3,:),col);hold on;
ylabel('\alpha [deg]')    
xlabel('time [sec]');


figure(8);
subplot(211)
plot(TOUT, chi, col);hold on;
ylabel('Course angle \chi [deg]')   

subplot(212)
plot(TOUT, gamma, col);hold on;
ylabel('Flight path angle \gamma [deg]')   
