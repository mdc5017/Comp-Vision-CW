% Task 4b
% M Paz Cardona

cd('C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 4\4b')

% http://www.cse.psu.edu/~rtc12/CSE486/lecture19_6pp.pdf
% http://www.sci.utah.edu/~acoste/uou/3dcv/project2/ArthurCOSTE_project2.pdf
% https://courses.engr.illinois.edu/cs543/sp2017/lectures/Lecture%2014%20-%20Epipolar%20Geometry%20and%20Stereo%20-%20Vision_Spring2017.pdf

%% Find FD
%T = readtable('Corresponding_keypoints_4b.xlsx');
num = xlsread('Corresponding_keypoints_4b.xlsx',2);

% remove rows and cols not needed
col_ind = [1:11,16:35];
num(:, col_ind) = [];
num(1:2,:) = [];
row_ind = [1:13,15:20,22:36,39,42:53,57:59];
num(row_ind, :) = [];

xL = num(:,1:2); % 7933
xR = num(:,3:4); % 7934

[fNorm8Point,inliers]  = estimateFundamentalMatrix(xL,xR, 'Method', 'Norm8Point');


%% Epipolar lines

F = fNorm8Point;

% read images
left_image = imrotate(imread('IMG_7923.jpg'),270);
right_image = imrotate(imread('IMG_7927.jpg'),270);
   
% plot images
figure;
subplot(1,2,1); imshow(left_image); axis image; hold on;
h = gca;
h.Visible = 'On';
subplot(1,2,2); imshow(right_image); axis image; hold on;
h = gca;
h.Visible = 'On';


colors = ['r', 'g', 'b', 'c', 'y', 'm', 'k', 'w'];
for i=1:8
    
    
    % right epiline
    p1 = [ xL(i,1) xL(i,2) 1];
    L_right = [F*p1']';    
    
    % left epiline
    p2 = [xR(i,1) xR(i,2) 1];
    L_left = p2*F;  
   

    color = colors(mod(i, 8)+1);
       
    % Left image
    subplot(1,2,1); 
    % keypoint
    plot1 = plot(xL(i,1), xL(i,2)); hold on;
    set(plot1, 'LineStyle', 'None', 'color', color,...
            'Marker', 'o', 'MarkerFaceColor', color);

    % epipolar lines
    points = lineToBorderPoints(L_left,size(left_image));
    line(points(:,[1,3])',points(:,[2,4])','color', color, 'LineWidth', 1.25); hold on;

    
    
    % Right image
    subplot(1,2,2); 
  
    plot2 = plot(xR(i,1), xR(i,2)) ; hold on;
    set(plot2, 'LineStyle', 'None', 'color', color,...
            'Marker', 'o', 'MarkerFaceColor', color);
     
    points = lineToBorderPoints(L_right,size(right_image)); hold on;
    line(points(:,[1,3])',points(:,[2,4])','color', color, 'LineWidth', 1.25); hold on;
    
end

%% Find epipole
color = [0.5, 0, 0.7];


% Left Image
[isIn, epipole] = isEpipoleInImage(fNorm8Point, size(left_image))
subplot(1,2,1)
% imshow(left_image)
% h = gca;
% h.Visible = 'On';
% hold on
plot(epipole(1,1), epipole(1,2),'color', 'k', 'Marker', 'o','MarkerFaceColor', color, 'MarkerEdgecolor', 'yellow')

% Right Image
subplot(1,2,2)
[isIn, epipole] = isEpipoleInImage(fNorm8Point', size(left_image))
% imshow(right_image)
% h = gca;
% h.Visible = 'On';
% hold on
plot(epipole(1,1), epipole(1,2),'color', 'k','Marker', 'o','MarkerFaceColor', color,'MarkerEdgecolor', 'yellow')