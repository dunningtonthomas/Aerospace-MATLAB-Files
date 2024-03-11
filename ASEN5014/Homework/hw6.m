%% 
close all; clear; clc;


%% Problem 4
q = [0.1;0.1;0.2;0.06];
xdot = [5;10];
J = jacob(q);

% Least norm solution
jInt = inv(J*J');
qdotLN = J'*inv(J*J')*xdot;

% Add from null space
nullJ = null(J);
q1 = qdotLN + nullJ(:,1);
q2 = qdotLN + nullJ(:,2);




function J = jacob(q)

    n = length(q);
    J = zeros(2, n);

    % X pos
    for i = 1:n
        totSum = 0;
        for j = i:n
            thetaSum = 0;
            for k = 1:j
                thetaSum = thetaSum + q(k);
            end
            totSum = totSum - sin(thetaSum);
        end
        J(1,i) = totSum;
    end

    % Y pos
    for i = 1:n
        totSum = 0;
        for j = i:n
            thetaSum = 0;
            for k = 1:j
                thetaSum = thetaSum + q(k);
            end
            totSum = totSum + cos(thetaSum);
        end
        J(2,i) = totSum;
    end

end


