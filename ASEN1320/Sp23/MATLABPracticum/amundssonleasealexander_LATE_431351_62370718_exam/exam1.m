clc, clear, close all;
accuracy = input('Enter accuracy:');

start = (1-(1/2))^2;
n = 3;

while start < ((1/exp(1)) - accuracy)
     
    start = (1-(1/n))^n;
    n = n + 1;
end

nFinal = n - 1;

actual = 1/(exp(1));

fprintf('n:%d \n', nFinal);
fprintf('Approximation:%4f \n', start);
fprintf('Actual:%4f \n', actual);