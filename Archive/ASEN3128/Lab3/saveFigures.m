%% This script will save all of the figures to a directory

%% Saving Figures to a directory
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');



cd('./Figures');

%First images to create: Problem 2 nonlinear eom response no control
stringsProb2 = {'P2rollPos'; 'P2rollAngles'; 'P2rollVel'; 'P2rollAngVel'; 'P2rollControl'; 'P2rollPath';
    'P2pitchPos'; 'P2pitchAngles'; 'P2pitchVel'; 'P2pitchAngVel'; 'P2pitchControl'; 'P2pitchPath';
    'P2yawPos'; 'P2yawAngles'; 'P2yawVel'; 'P2yawAngVel'; 'P2yawControl'; 'P2yawPath';
    'P2rollRatePos'; 'P2rollRateAngles'; 'P2rollRateVel'; 'P2rollRateAngVel'; 'P2rollRateControl'; 'P2rollRatePath';
    'P2pitchRatePos'; 'P2pitchRateAngles'; 'P2pitchRateVel'; 'P2pitchRateAngVel'; 'P2pitchRateControl'; 'P2pitchRatePath';
    'P2yawRatePos'; 'P2yawRateAngles'; 'P2yawRateVel'; 'P2yawRateAngVel'; 'P2yawRateControl'; 'P2yawRatePath'};
stringsProb2 = flip(stringsProb2);


%Next images to create: Problem 6 
stringsProb6 = {'P6rollRatePos'; 'P6rollRateAngles'; 'P6rollRateVel'; 'P6rollRateAngVel'; 'P6rollRateControl'; 'P6rollRatePath';
    'P6pitchRatePos'; 'P6pitchRateAngles'; 'P6pitchRateVel'; 'P6pitchRateAngVel'; 'P6pitchRateControl'; 'P6pitchRatePath';
    'P6yawRatePos'; 'P6yawRateAngles'; 'P6yawRateVel'; 'P6yawRateAngVel'; 'P6yawRateControl'; 'P6yawRatePath'};
stringsProb6 = flip(stringsProb6);    


for i = 1:length(FigList)
    currFig = FigList(i);
    figName = num2str(get(currFig, 'Number'));
    set(0, 'CurrentFigure', currFig);
    saveas(currFig, strcat(stringsProb6{i}, '.png'));   
end


%% Coming back

cd('../');