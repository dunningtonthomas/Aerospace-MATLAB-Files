function [observable, elevationAngle, cameraAngle] = auto_check_view(r, facetNumber, F, V)
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

%Get the three vectors defining the face
face = F(facetNumber, :);
v1 = V(face(1), :)';
v2 = V(face(2), :)';
v3 = V(face(3), :)';

v12 = v2 - v1;
v13 = v3 - v1;

%Defining the normal vector to the face
n = cross(v12, v13);
nhat = n ./ norm(n);

%Define vector from the center of bennu to the center of the face
rFace = (v1 + v2 + v3) ./ 3;

%Defining vector from the face to the spacecraft
rFS = r - rFace;

%Finding angle between rFS and the normal of the face
elevationAngle = pi/2 - acos(dot(rFS, nhat) / norm(rFS));

%Finding field of view angle
cameraAngle = acos(dot(-rFS, -r) / (norm(rFS) * norm(r)));

%Determining whether or not the facet is visible
if(elevationAngle >= 15*pi/180 && cameraAngle <= FOV)
    observable = 1;
else
    observable = 0;
end

end
