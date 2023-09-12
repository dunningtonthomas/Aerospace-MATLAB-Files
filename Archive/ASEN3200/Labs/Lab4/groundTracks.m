function [longitude, lattitude] = groundTracks(rVec, facets, vertices, targets, sat)
%GROUNDTRACKS 
%This function plots the ground tracks of the inputted trajetory of the
%spacecraft and also plots the targets on the ground tracks
%INPUTS:
%   rVec = n x 3 vector of inertial coordinates of the spacecraft
%   facets = facets of the asteroids
%   vertices = vertices of the asteroid
%   targets = facet numbers of the targets
%   sat = satellite label (string)
%OUTPUTS: 


%Get the position vectors of the target facets
targFaces = facets(targets, :);

%Use triangulation to get vectors to 
TR = triangulation(targFaces, vertices);
rFVec = incenter(TR);

%Get the coordinates for the targets
[targLong,targLat,~] = cart2sph(rFVec(:,1), rFVec(:,2), rFVec(:,3));
targLong = targLong * 180/pi;
targLat = targLat * 180/pi;


%Create vector of rotation of the vertices due to bennu's rotation
t0 = 0;
tf = 60*60*24*7; %1 week timespan
period = 4.297461 * 3600; %Time period of Bennu
angRate = 2*pi / period;
thetaVec = t0*angRate:60*angRate:tf*angRate;

%Rotate the satellite positions into the body frame
rVec_B = zeros(size(rVec));

for i = 1:length(rVec(:,1))
    %Rotate Sat vertices
    rotMat = [cos(-thetaVec(i)), -sin(-thetaVec(i)), 0; sin(-thetaVec(i)), cos(-thetaVec(i)), 0; 0, 0, 1];
    rVec_B(i,:) = (rotMat * rVec(i,:)')';
end

%Convert into spherical coordinates to plot lat/long 
[azimuth,elevation,~] = cart2sph(rVec_B(:,1), rVec_B(:,2), rVec_B(:,3));

%Convert to degrees
longitude = azimuth * 180/pi;
lattitude = elevation * 180/pi;

%Plot the result
figure();
set(0, 'defaulttextinterpreter', 'latex')
plot(0,0,'b', 'linewidth', 3); %Used for legend
hold on
grid on
scatter(targLong, targLat, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r', 'SizeData', 8);
plot(longitude, lattitude, '.b');

xlim([-180 180]);
ylim([-90 90]);
xlabel('Longitude ($$^{\circ}$$)');
ylabel('Latitude ($$^{\circ}$$)');
title(strcat(sat, ' Ground Tracks'));
legend('Ground Track', 'Target Facet', 'location', 'ne');


end

