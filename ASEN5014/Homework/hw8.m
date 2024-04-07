%% Clean
close all; clear; clc;


%% Problem 2
A = [4 -2; -3 5];
[vec, val] = eig(A);

maxVec = vec(:,2);
maxVec = maxVec / norm(maxVec);

maxTemp = [-2/3; 1];
maxTemp = maxTemp / norm(maxTemp);


%% Problem 4
load('my_secret_REV1.mat');

x = my_secret(1:7,1);
testPairs = my_secret(1:7,:);
A = zeros(7,5);

% Create the linear mapping
for j = 1:7
    col = 1;
    for i = flip(1:5)
        A(j,col) = x(j)^(i-1);
        col = col + 1;
    end
end


% Loop through different values of k and perform least squares
passInd = 1;
passVec = 0;
kvals = 1:14;
residVec = zeros(size(kvals));
for k = kvals
    A = generateA(k, my_secret);
    pvec = A'*A\A'*my_secret(:,2);
    passVec(passInd) = pvec(end);
    residVec(passInd) = sqrt(mean((my_secret(:,2) - A*pvec).^2));
    passInd = passInd + 1;
end




%% Plotting
figure();
plot(kvals, passVec, 'linewidth', 2,'Color','r');
xline(8, 'Label','K = 8');
grid on
xlabel('K Values');
ylabel('P0');
title('K Values verus P0')

% Residuals
% Create semi-logarithmic plot
figure;
semilogy(kvals, residVec, 'linewidth', 2);
xlabel('K Value');
ylabel('Root Mean Square Residual');
title('Least Squares Error');
xline(8, 'Label','K = 8');
grid on;



%% Functions
% This function generates the A matrix given a k value and the x,y pairs
function A = generateA(k, pairs)
    % Get x values in the number pairs
    x = pairs(:,1);
    A = zeros(length(x),k);

    % Create the linear mapping
    for j = 1:length(x)
        col = 1;
        for i = flip(1:k+1)
            A(j,col) = x(j)^(i-1);
            col = col + 1;
        end
    end
end






