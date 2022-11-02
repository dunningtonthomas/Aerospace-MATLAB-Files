%% This script will save all of the figures to a directory

%% Saving Figures to a directory
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');


cd('./Figures');

%First images to create: Problem 3 linearized closed loop response
stringsProb3 = {'windAng3a', 'control3a', 'path3a', 'angVel3a', 'vel3a', 'euler3a', 'pos3a'};
%stringsProb3 = flip(stringsProb3);

stringsProb3b = {'windAng3b', 'control3b', 'path3b', 'angVel3b', 'vel3b', 'euler3b', 'pos3b'};
%stringsProb3 = flip(stringsProb3);




for i = 1:length(FigList)
    currFig = FigList(i);
    figName = num2str(get(currFig, 'Number'));
    set(0, 'CurrentFigure', currFig);
    saveas(currFig, strcat(stringsProb3b{i}, '.png'));   
end


%% Coming back

cd('../');