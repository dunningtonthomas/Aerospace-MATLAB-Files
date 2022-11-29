%% This script will save all of the figures to a directory
%Thomas Dunnington 11/28/2022

%% Saving Figures to a directory
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');


cd('./Figures');

%First images to create: Problem 3 linearized closed loop response
stringsProb1 = {'wing2min', 'tail2min', 'nose2min', 'all5min', 'all2min'};
%stringsProb3 = flip(stringsProb3);


for i = 1:length(FigList)
    currFig = FigList(i);
    figName = num2str(get(currFig, 'Number'));
    set(0, 'CurrentFigure', currFig);
    saveas(currFig, strcat(stringsProb1{i}, '.png'));   
end


%% Coming back

cd('../');