%% This script will save all of the figures to a directory

%% Saving Figures to a directory
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');


cd('./Figures');

%First images to create: Problem 3 linearized closed loop response
stringsProb2a = {'2Dpath', 'courseAngle', 'windAngles', 'controlSurfaces', '3Dpath', 'angVel', 'vel', 'euler', 'pos'};
%stringsProb3 = flip(stringsProb3);

for i = 1:length(FigList)
    currFig = FigList(i);
    figName = num2str(get(currFig, 'Number'));
    set(0, 'CurrentFigure', currFig);
    saveas(currFig, strcat(stringsProb2a{i}, '.png'));   
end


%% Coming back

cd('../');