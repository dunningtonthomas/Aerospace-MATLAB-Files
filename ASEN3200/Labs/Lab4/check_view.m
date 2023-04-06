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


end

