%% Clean Up
close all; clear; clc;

%% Test serial
port = 'COM4';
s = serialport(port,115200);


% Set properties for the serial port
set(s, 'Terminator', 'LF');  % Specify the terminator for the data
set(s, 'Timeout', 10);       % Set the timeout in seconds

% Open the serial port
fopen(s);

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



