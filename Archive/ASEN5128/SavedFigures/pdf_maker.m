% Close current figures
close all;

% Change directory
folderName = "Hw7_Problem5_Path";
cd(folderName)

% List of the PNG files to be added to the PDF
files = {'Figure_1.png', 'Figure_2.png', 'Figure_3.png', 'Figure_4.png', 'Figure_5.png', 'Figure_6.png'};
%files = {'Figure_3.png', 'Figure_4.png', 'Figure_5.png', 'Figure_6.png', 'Figure_7.png', 'Figure_9.png'};

% Create a new figure with a larger size
figure('Units', 'normalized', 'Position', [0, 0, 0.8, 1]);

% Set up a tiled layout for 3 rows and 2 columns with no padding
tiledlayout(3, 2, 'Padding', 'none', 'TileSpacing', 'none');

% Loop through each file and add it to the layout
for i = 1:length(files)
    nexttile; % Move to the next tile
    img = imread(files{i}); % Read the image
    imshow(img, 'Border', 'tight'); % Display the image with no border
    axis off; % Turn off axis
end

% Save the figure as a PDF
exportgraphics(gcf, 'compiled_figures.pdf', 'ContentType', 'vector');


% Come back
cd ..