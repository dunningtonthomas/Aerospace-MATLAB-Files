function [facets, vertices] = read_obj(fileName)
%Summary: This function reads in an object file and outputs the vertices
%and facets.
%Author: Thomas Dunnington
%Date: 4/6/2023
%INPUTS: fileName = name of the object file
%OUTPUTS:
%   facets = n x 3 matrix of vertices that form each face
%   vertices = m x 3 matrix of vertex locations in implied body frame

% fileID = fopen(fileName);
% C = textscan(fileID, '%s %f %f %f');
% 
% strings = string([C{:,1}]);
% data = [C{:,2}, C{:,3}, C{:,4}];
% 
% vertices = data(strings == 'v', :);
% facets = data(strings == 'f', :);

fileID = fopen(fileName);
raw = textscan(fileID, '%s', 'delimiter', '\n');
strings = string([raw{1,1}]);

%Get rid of comments
checker = 1;
ind = 1;
while(checker)
    checker = 0;
    string1 = strings{ind};
    if(string1(1) == '#') %Condition for comment
        strings(1) = [];
        checker = 1;
    end
end

%Parsing through the strings with spaces
strings_split = split(strings);

%First column is v or f, the other three are the faces and vertices
%coordinates
vOrf = strings_split(:,1);
data = strings_split(:,2:end);
data = str2double(data);

vertices = data(vOrf == 'v', :);
facets = data(vOrf == 'f', :);

end

