


vec = [0 0 0 0 0 0 1 1 1 0 0 0 0 0];
vecPos = linspace(1,100, length(vec));
time = linspace(0,10, length(vec));

logVec = vec == 1;

visibleXPositions = vecPos(logVec);
time2 = time(logVec);

figure();
plot(time, vecPos);
hold on
plot(time2, visibleXPositions, '*');

