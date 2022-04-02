%% Monte Carlo Simulation

% Mathematical technique to predict the possible locations of the rocket's
% impact. 
% Need to determine the uncertainties
% List of uncertainties and ranges of values
% Each simulation randomly selects parameter values for the simulations
% Create distribution of possible flight impacts in the xy plane
% Plot error ellipses on the distribution representing 1 2 and 3 stds
% Covariance, measures the joint variability of two random variables
% Correlation coefficient, measures the linear correlation between two sets
% of data. Lies between -1 and 1, the closer to 1, the closer the data
% alligns
% corr(x, y) computates the correlation coefficient of the two data sets
% covMat = [stdX^2, corr*stdX*stdY; corr*stdX*stdY, stdY^2];
% Use [v,d] = eig(mat) to compute the eigen values and vectors of the mat
% The eigenvalues in D give you the dimensions of the principal azes of the
% error allipse
% The eigenvectors give you the orientation of the error ellipse