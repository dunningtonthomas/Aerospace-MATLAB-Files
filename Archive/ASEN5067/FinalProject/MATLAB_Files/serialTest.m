%% Clean Up
close all; clear; clc;

%% Test serial
port = 'COM4';
s = serialport(port,19200);

% Set properties for the serial port
s.configureTerminator("LF", "LF");

% Other test
command = "DIST";
writeline(s,"DIST_OFF"); 

% Read
%readline(s)

%%

% Open the serial port
fopen(s);

% Stop sending
charString = 'DIST_OFF';
%fwrite(s, charString)

try
    while isvalid(s)
        % Read data from the serial port
        data = fgets(s);
        
        % Display the received data
        disp(['Received data: ' data]);
        
        % Add your processing code here
        
        % Pause for a short time to avoid high CPU usage
        pause(0.1);
    end
catch e
    % Handle any exceptions (e.g., if the user closes the figure or errors occur)
    disp(['Error: ' e.message]);
end

% Close the serial port when done
fclose(s);
delete(s);





