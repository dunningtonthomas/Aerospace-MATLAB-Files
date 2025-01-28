%% Clean
close all; clear; clc;


%% Problem 1
total_number_hands = nchoosek(52,2);

% Sample and sum
sum = 0;
sum1 = 0;
for i = 1:10000000
    xi = rand() - 0.5;
    xj = rand() - 0.5;
    xk = rand() - 0.5;
    xl = rand() - 0.5;

    sum(i) = (xi + xj) / 2;
    sum1(i) = (xi + xj + xk + xl) / 4;
end


% Plot the 50 bin historgram
% Create a histogram with 50 bins
figure();
histogram(sum, 50);

% Add labels and title for clarity
xlabel('X');
ylabel('Frequency');
title('Two value sum 50 bin histogram 10000 samples');


% Four sum plot
figure();
histogram(sum1, 50);

% Add labels and title for clarity
xlabel('X');
ylabel('Frequency');
title('Four value sum 50 bin histogram 10000 samples');

