close all; clear variables; clc; 

Sat1Pos = readmatrix("Sat1Position.csv");
Sat1Vis = readmatrix("Sat1Visibility.csv");
x1 = Sat1Pos(:,1);
y1 = Sat1Pos(:,2);
z1 = Sat1Pos(:,3);




Sat2Pos = readmatrix("Sat2Postion.csv");
Sat2Vis = readmatrix("Sat2Visibility.csv");
x2 = Sat2Pos(:,1);
y2 = Sat2Pos(:,2);
z2 = Sat2Pos(:,3);








fig1 = plot3(x1,y1,z1);

hold on; 

fig2 = plot3(x2,y2,z2);

 for i = 1:1441
   
     if Sat1Vis(i) == true
       
        ISS = plot3(x1(i), y1(i), z1(i), 'm^');
        
     end
     
     
     if Sat2Vis(i) == true

        HUB = plot3(x2(i),y2(i),z2(i),'k*');
      
    end
end



xlabel("X-axis");
ylabel("Y-axis");
zlabel("Z-axis");
legend([fig1, fig2, ISS, HUB],'ISS Orbit', 'Hubble Orbit','ISS Visible Points', 'Hubble Visible Points');
title("Points of Visibility of ISS and Hubble Along Their Orbital Paths");
grid on; 


