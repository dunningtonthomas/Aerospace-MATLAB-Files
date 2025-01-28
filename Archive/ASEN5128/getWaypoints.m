function waypoints = getWaypoints(filename, h_trim)
%GETWAYPOINTS Reads in the RRT waypoints from filename and returns the 3D
%waypoints for the aircraft to follow
data = readmatrix(filename);
waypoints = [data, ones(length(data(:,1)), 1) .* h_trim];
end

