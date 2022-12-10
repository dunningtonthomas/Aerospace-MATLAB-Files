clc; close all; clear all;

s1pos = readmatrix("Sat1Position.csv");
s2pos = readmatrix("Sat2Position.csv");

s1vis = readmatrix("Sat1Visibility.csv");
s2vis = readmatrix("Sat2Visibility.csv");

gspos = readmatrix("GSPosition.csv");

s1unvis = s1pos;
s2unvis = s2pos;

hold on;

plot3(s1pos(: , 1), s1pos(: , 2) , s1pos(: , 3), '-r', s2pos(: , 1), s2pos(: , 2) , s2pos(: , 3), '-g', gspos(: , 1), gspos(: , 2) , gspos(: , 3), '-k');

for i = 1:length(s1vis) 

    if(s1vis(i) == 1)
        plot3(s1pos(i, 1), s1pos(i, 2), s1pos(i, 3), '.r');

    end

    if(s2vis(i) == 1)
        plot3(s2pos(i, 1), s2pos(i, 2), s2pos(i, 3), '.g');

    end
end

title("Satilight posistion with Ground Station visiability");
xlabel("x (kilometers)");
ylabel("y (kilometers)");
zlabel("z (kilometers)");
legend("ISS", "Hubble", "Ground Station", "Visability");

savefig('satilight_visability.fig');

