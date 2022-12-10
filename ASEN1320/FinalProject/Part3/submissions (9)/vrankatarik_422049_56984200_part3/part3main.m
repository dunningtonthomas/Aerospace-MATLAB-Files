clear; close all; clc;

file = "Sat1Position.csv";      %load files, copy data into matricies
file1 = "Sat2Position.csv";
file2 = "Sat1Visibility.csv";
file3 = "Sat2Visibility.csv";

myMatrix = readmatrix(file);
myMatrix1 = readmatrix(file1);
myMatrix2 = readmatrix(file2);
myMatrix3 = readmatrix(file3);

sat1 = zeros(1440, 3);                %arrays will have zeros if nothing is inputted
sat2 = zeros(1440, 3);

for i = 1:1440                  %for loop copies values in only if the visibility value = 1

if myMatrix2(i) == 1

    sat1(i, 1) = myMatrix(i, 1);
    sat1(i, 2) = myMatrix(i, 2);
    sat1(i, 3) = myMatrix(i, 3);

end

if myMatrix3(i) == 1

    sat2(i, 1) = myMatrix1(i, 1);
    sat2(i, 2) = myMatrix1(i, 2);
    sat2(i, 3) = myMatrix1(i, 3);

end

end

for i = 1:1440

plot3(sat1(:, 1), sat1(:, 2), sat1(:, 3), ".")   %3d plot of segments of orbit where satellites are visible
hold on
plot3(sat2(:, 1), sat2(:, 2), sat2(:, 3), ".")   

xlabel("x position")
ylabel("y position")
zlabel("z position")
legend("Satellite 1 Visible","Satellite 2 Visible",'Location','northwest');
hold off


end
