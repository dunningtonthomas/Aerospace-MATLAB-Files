function [observable, elevationAngle, cameraAngle] = check_view(r, facetNumber, F, V)
%CHECK_VIEW
%Author: Thomas Dunnington
% Description:
% This function accepts an initial state, facet number, list of facets, and a list of verticies in km and
% outputs the if the facet is observable, the elevation angle of the facet, and the camera angle of the
% facet.
% Inputs:
%   r - [3 by 1 ] spacecraft Cartesian position vector in the body frame [x, y, z]T
%   facetNumber - scalar, facet index
%   F - [n x 3] matrix of vertices that form each face
%   V - [m x 3] matrix of vertex locations in implied body frame
% Outputs:
%   observable - int, 0 for unobservable, 1 for observable
%   elevationAngle - scalar, elevation of spacecraft relative to the facet plane in radians
%   cameraAngle - scalar, angle of facet center relative to camera boresight

%Define FOV
FOV = pi / 9;


%% Triangulation method with vectors
TR = triangulation(F, V);
rFVec = incenter(TR);
rVec = r.*ones(length(F(:,1)), 3);
norms = faceNormal(TR);

%Getting the vector to the face and the face normal
rF = rFVec;
n = norms;

%Defining the vector from the face to the spacecraft
rFS = rVec - rF;

%Finding angle between rFS and the normal of the face
elevationAngle = pi/2 - acos(dot(rFS, n, 2) ./ (vecnorm(rFS, 2, 2) .* vecnorm(n, 2, 2)));

%Finding field of view angle
cameraAngle = acos(dot(-1*rFS, -1*rVec, 2) ./ (vecnorm(rFS,2,2) .* vecnorm(rVec,2,2)));

%Determining whether or not the facet is visible
observable = elevationAngle >= 15*pi/180 & cameraAngle <= FOV;

end

