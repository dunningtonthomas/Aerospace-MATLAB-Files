%% This script will save all of the figures to a directory

%% Saving Figures to a directory
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');


cd('./Figures');

%First images to create: Problem 3 linearized closed loop response
stringsProb3 = {'P3rollPos'; 'P3rollAngles'; 'P3rollVel'; 'P3rollAngVel'; 'P3rollControl'; 'P3rollPath';
    'P3pitchPos'; 'P3pitchAngles'; 'P3pitchVel'; 'P3pitchAngVel'; 'P3pitchControl'; 'P3pitchPath';
    'P3rollRatePos'; 'P3rollRateAngles'; 'P3rollRateVel'; 'P3rollRateAngVel'; 'P3rollRateControl'; 'P3rollRatePath';
    'P3pitchRatePos'; 'P3pitchRateAngles'; 'P3pitchRateVel'; 'P3pitchRateAngVel'; 'P3pitchRateControl'; 'P3pitchRatePath'};
stringsProb3 = flip(stringsProb3);

%Next images to create: Problem 4 linearized closed loop response AND
%Non-linear
stringsProb4 = {'P4rollPos'; 'P4rollAngles'; 'P4rollVel'; 'P4rollAngVel'; 'P4rollControl'; 'P4rollPath';
    'P4pitchPos'; 'P4pitchAngles'; 'P4pitchVel'; 'P4pitchAngVel'; 'P4pitchControl'; 'P4pitchPath';
    'P4rollRatePos'; 'P4rollRateAngles'; 'P4rollRateVel'; 'P4rollRateAngVel'; 'P4rollRateControl'; 'P4rollRatePath';
    'P4pitchRatePos'; 'P4pitchRateAngles'; 'P4pitchRateVel'; 'P4pitchRateAngVel'; 'P4pitchRateControl'; 'P4pitchRatePath'};
stringsProb4 = flip(stringsProb4);


stringsProb7 = {'P7latPos'; 'P7latAngles'; 'P7latVel'; 'P7latAngVel'; 'P7latControl'; 'P7latPath';
    'P7longPos'; 'P7longAngles'; 'P7longVel'; 'P7longAngVel'; 'P7longControl'; 'P7longPath'};
stringsProb7 = flip(stringsProb7);

stringsProb72 = {'P72latPos'; 'P72latAngles'; 'P72latVel'; 'P72latAngVel'; 'P72latControl'; 'P72latPath';
    'P72longPos'; 'P72longAngles'; 'P72longVel'; 'P72longAngVel'; 'P72longControl'; 'P72longPath'};
stringsProb72 = flip(stringsProb72);

for i = 1:length(FigList)
    currFig = FigList(i);
    figName = num2str(get(currFig, 'Number'));
    set(0, 'CurrentFigure', currFig);
    saveas(currFig, strcat(stringsProb72{i}, '.png'));   
end


%% Coming back

cd('../');