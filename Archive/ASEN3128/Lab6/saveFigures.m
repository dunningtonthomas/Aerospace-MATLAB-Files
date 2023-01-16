%% This script will save all of the figures to a directory

%% Saving Figures to a directory
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');


cd('./Figures');

%First images to create: Problem 3 linearized closed loop response
stringsProb2a = {'control2a', 'path2a', 'angVel2a', 'vel2a', 'euler2a', 'pos2a'};
%stringsProb3 = flip(stringsProb3);

stringsProb2b = {'control2b', 'path2b', 'angVel2b', 'vel2b', 'euler2b', 'pos2b'};
%stringsProb3 = flip(stringsProb3);

stringsProb2c = {'control2c', 'path2c', 'angVel2c', 'vel2c', 'euler2c', 'pos2c'};
%stringsProb3 = flip(stringsProb3);

stringsProb3a = {'control3a', 'path3a', 'angVel3a', 'vel3a', 'euler3a', 'pos3a'};
%stringsProb3 = flip(stringsProb3);

stringsProb3b = {'control3b', 'path3b', 'angVel3b', 'vel3b', 'euler3b', 'pos3b'};
%stringsProb3 = flip(stringsProb3);

stringsProb3c = {'control3c', 'path3c', 'angVel3c', 'vel3c', 'euler3c', 'pos3c'};
%stringsProb3 = flip(stringsProb3);

stringsProb3d = {'control3d', 'path3d', 'angVel3d', 'vel3d', 'euler3d', 'pos3d'};
%stringsProb3 = flip(stringsProb3);

stringsProb3e = {'control3e', 'path3e', 'angVel3e', 'vel3e', 'euler3e', 'pos3e'};
%stringsProb3 = flip(stringsProb3);

stringsProb2d_1 = {'control2d_1', 'path2d_1', 'angVel2d_1', 'vel2d_1', 'euler2d_1', 'pos2d_1'};
%stringsProb3 = flip(stringsProb3);

stringsProb2d_2 = {'control2d_2', 'path2d_2', 'angVel2d_2', 'vel2d_2', 'euler2d_2', 'pos2d_2'};
%stringsProb3 = flip(stringsProb3);

stringsProb2d_3 = {'control2d_3', 'path2d_3', 'angVel2d_3', 'vel2d_3', 'euler2d_3', 'pos2d_3'};
%stringsProb3 = flip(stringsProb3);

for i = 1:length(FigList)
    currFig = FigList(i);
    figName = num2str(get(currFig, 'Number'));
    set(0, 'CurrentFigure', currFig);
    saveas(currFig, strcat(stringsProb2d_3{i}, '.png'));   
end


%% Coming back

cd('../');