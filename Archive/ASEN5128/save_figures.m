% Script to save all currently open figures to a folder

% Specify the folder to save figures
folderName = 'SavedFigures';
if ~exist(folderName, 'dir')
    mkdir(folderName);  % Create the folder if it does not exist
end

% Change directory
cd(folderName)

% Specify the subfolder
subfolder = 'Hw9_Problem2_3';
if ~exist(subfolder, 'dir')
    mkdir(subfolder);  % Create the folder if it does not exist
end

% Find all figure objects
figures = findobj('Type', 'figure');

% Loop through all open figures and save them
for i = 1:length(figures)
    figure(figures(i));  % Bring each figure to focus
    
    % Generate a file name for the figure
    fileName = fullfile(subfolder, ['Figure_', num2str(figures(i).Number), '.png']);
    
    % Save the figure
    saveas(figures(i), fileName);  % Save the figure
end

disp([num2str(length(figures)), ' figures saved successfully.']);

% Come back
cd ..
