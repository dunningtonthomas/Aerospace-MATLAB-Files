%% Clean Up
close all; clear; clc;

%% Parse the received data
test = "D=189cm;4400";
test2 = convertStringsToChars(test);

servoBool = 0;
distVal = '';
for i = 1:length(test2)
    if(test2(i) == 'D' || test2(i) == '=') % Do nothing
        continue;
    end
    
    if(test2(i) == ';') % Break the loop
        i = i + 1;
        break
    end

    distVal(end + 1) = test2(i);
end

servoVal = test2(i:end);









