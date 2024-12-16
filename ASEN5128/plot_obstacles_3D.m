function fig_num = plot_obstacles_3D(filename)
    % Read the obstacle data from the file
    obstacle_data = readmatrix(filename);

    % Number of obstacles
    num_obstacles = size(obstacle_data, 1);

    % Height of obstacles
    obstacle_height = 150;

    % Create a new figure
    fig_num = figure;
    hold on;

    % Define obstacle color and transparency
    obstacle_color = [1, 0, 0]; % Red color
    face_alpha = 0.5; % Transparency for obstacle faces

    % Add a dummy handle for the legend
    patch_handle = patch(nan, nan, obstacle_color, 'FaceAlpha', face_alpha, ...
                         'DisplayName', 'Obstacles');

    % Loop through each obstacle
    for i = 1:num_obstacles
        % Extract the vertices for the obstacle (2D base)
        vertices_2D = reshape(obstacle_data(i, :), 2, []).';

        % Add the bottom and top vertices for the 3D obstacle
        vertices_bottom = [vertices_2D, zeros(size(vertices_2D, 1), 1)];
        vertices_top = [vertices_2D, obstacle_height * ones(size(vertices_2D, 1), 1)];

        % Combine bottom and top vertices
        vertices = [vertices_bottom; vertices_top];

        % Define faces for the 3D obstacle
        num_vertices = size(vertices_2D, 1);
        faces = [];

        % Bottom face
        faces = [faces; 1:num_vertices];

        % Top face (shifted by num_vertices)
        faces = [faces; num_vertices + (1:num_vertices)];

        % Side faces
        for j = 1:num_vertices
            next = mod(j, num_vertices) + 1;
            faces = [faces; j, next, next + num_vertices, j + num_vertices];
        end

        % Plot the obstacle as a patch
        patch('Vertices', vertices, 'Faces', faces, 'FaceColor', obstacle_color, ...
              'FaceAlpha', face_alpha, 'EdgeColor', 'none', 'HandleVisibility', 'off');
    end

    % Format the plot
    xlabel('East (m)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('North (m)', 'FontSize', 12, 'FontWeight', 'bold');
    zlabel('Altitude (m)', 'FontSize', 12, 'FontWeight', 'bold');
    title('3D Obstacle Plot', 'FontSize', 14, 'FontWeight', 'bold');
    grid on;
    axis equal;
    view(3); % Default 3D view angle

    % Add legend
    legend('show', 'Location', 'best', 'FontSize', 11);
end


