load("all_init_conditions.mat")

%% Initial conditions
gMoon= 1.6;
isp= 225;
Init=length(all_init_conditions(:,1)); 
dydt= @(t, y)GravityTurnEOM(t,y,gMoon,isp);% takes t and y as inputs and calls the EOM Func with t,y,gMoon and isp as inputs
options = odeset('RelTol', 10^-10); % Set error tolerance

%%%% -2 Error tolerance incorrect
%%%% -5 Code does not run
%%%% -2 incorrect time step for the ode function
%%%% -2 incorrectly passed in a row vector to the ode call
%%%% -2 t is not defined anywhere and causes an error
%%%% -2 g is not defined anywhere, needed to pass in gMoon
%%%% -2 incorrect syntax for updating the final time, program will
%%%% infinitely run
%%%% -2 inconsistency between h and hf
%%%% -2 vf defined, error with Vf
%%%% -2 altitude score referenced with incorrect name
%%%% -2 error in title call for the plot

totalOff = 2 + 5 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2 + 2;


%% Integration
tf=0;
t0=0;

for  i= 1:Init % Loops through each row of the matrix
    %Assigning iteration of the loop
v0= all_init_conditions(1,i);
G0= all_init_conditions(2,i);
h0= all_init_conditions(3,i);
x0= all_init_conditions(4,i);
m0= all_init_conditions(5,i);
array1= [v0;G0;h0;x0;m0];% Combining all the initial contidions into an array
hf=h0;
    while hf > 0.1 % loop that will continue if the altitute is less that 0.1 m
        tf = tf + 0.2;
        tspan=[0, tf]; % set the current time + 0.2 secs which is our time step
        [tout,yout]= ode45(dydt, tspan,array1); %integration
        %Final values given by the outputs of the ODE45
        vf= yout(end,1);
        Gf= yout(end,2);
        hf= yout(end,3);
        xf= yout(end,4);
        mf= yout(end,5);
        t=tout(end);
    end
  
   if Gf> -85*pi/180 || Gf< -95*pi/180 || Gf>90*pi/180 %if statement that checks all the parameters of the flight angle and if pass it will set the scores to 0
       AltitutScore(i)=0;
       VelocityScore(i)=0;
       GammaScore(i)=0;
       TotalScore(i)=0;
%if not then we will use the equations for each score
   else
       AltitutScore(i)= (1-hf)*100;
       VelocityScore(i)=(1-abs(vf/2))*200;
       GammaScore(i)= (1-abs((pi/2)+Gf))*200;
       TotalScore(i)=AltitutScore(i) +VelocityScore(i) +GammaScore(i); 

   end
   Endtime(i)=t;
end


[~,indx]= max(TotalScore);
T= Endtime(indx);
dt= t0:0.2:T;

[Tout,BestStates]= ode45(dydt,dt,all_init_conditions(:,indx),options);


%% Plotting
subplot(3,1,1)
plot(Tout,BestStates(:,1))
title('Velocity vs. Time')
xlabel('Time (s)')
ylabel('Velocity (m/s')

subplot(3,1,2)
plot(Tout,BestStates(:,2))
title('Flight path Angle vs.Time ')
xlabel('Time(s)')
ylabel('Flight path Angle (rad)')

subplot(3,1,3)
plot(Tout,BestStates(:,3))
title('Altitude vs. Time')
xlabel('Time(s)')
ylabel('Altitude(m)')

    