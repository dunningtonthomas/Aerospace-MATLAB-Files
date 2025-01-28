clc, clear, close all;

d= 5;
actv= 1/(exp(1));
n=1;
acc = input('Enter Accuracy:');
for i=1:n
    if acc >= 0.001
        while d > acc
        approx = (1 - (1/i))^i;
        d= actv-approx;
        n=n+1;
        end
    end
end
fprintf('n:%d Approximation:%f Actual:%f',n,approx,actv);
