clc, clear, close all;

Accuracy = input('Enter Accuracy:');
if Accuracy >= 0.001
    for i=1:1000000
        difference = 1 - ((1/i)^i);
        if difference < Accuracy
            index = i;
            Approximation = difference;
            Actual = 1/exp(1);
            break
        end
    end

else
    Accuracy = input('Enter Accuracy:');

end

fprintf('n %.5f Approximation: %.5f Actual: %.5f', index, Approximation, Actual)
% fprintf('n','%.5f', ' Approximation:','%.5f',' Actual:', '%.5f', index, Approximation, Actual)


