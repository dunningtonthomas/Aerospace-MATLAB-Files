function [facets, vertices] = read_obj(fileName)
%Summary: This function reads in an object file and outputs the vertices
%and facets.
%Author: Thomas Dunnington
%Date: 4/6/2023
%INPUTS: fileName = name of the object file
%OUTPUTS:
%   facets = n x 3 matrix of vertices that form each face
%   vertices = m x 3 matrix of vertex locations in implied body frame

fileID = fopen(fileName);
C = textscan(fileID, '%s %f %f %f');

strings = string([C{:,1}]);
data = [C{:,2}, C{:,3}, C{:,4}];

vertices = data(strings == 'v', :);
facets = data(strings == 'f', :);


end
