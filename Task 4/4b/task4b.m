% Task 4b
% M Paz Cardona

cd('C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 4\4b')


%% Find FD
%T = readtable('Corresponding_keypoints_4b.xlsx');
num = xlsread('Corresponding_keypoints_4b.xlsx',2);

% remove rows and cols not needed
col_ind = [1:19,24:35];
num(:, col_ind) = [];
num(1:2,:) = [];
row_ind = [1:36,42:49,53:59];
num(row_ind, :) = [];

%%

xR = num(:,1:2); % 7933
xL = num(:,3:4); % 7934

%%
[fNorm8Point,inliers]  = estimateFundamentalMatrix(xL,xR, 'Method', 'Norm8Point');


%% Show keypoints and epipolar lines

left_image = imrotate(imread('IMG_7934.jpg'),270);
right_image = imrotate(imread('IMG_7933.jpg'),270);
figure;
subplot(1,2,1); imshow(left_image); axis image; hold on;
subplot(1,2,2); imshow(right_image); axis image; hold on;

[~,n,~] = size(left_image);
F = fNorm8Point;
[~, ~, FV] = svd(fNorm8Point);
left_epipole = FV(:,3);
left_epipole = left_epipole/left_epipole(3);
%right_epipole = FU(:,3);
%right_epipole = right_epipole/right_epipole(3);

left_x = xL(:,1);
left_y = xL(:,2);
right_x = xR(:,1);
right_y = xR(:,2);


% Start plotting:
for i=1:size(left_x,1)
    
    % finding the epipolar line on the left image itself:
    % Hence using the left epipole and the given input point on left
    % image we plot the epipolar line on the left image
    left_epipolar_x = 1:n;
    left_epipolar_y = left_y(i) + (left_epipolar_x-left_x(i))*...
        (left_epipole(2)-left_y(i))/(left_epipole(1)-left_x(i));
    
    % plot on left image
    subplot(1,2,1);
    plot(left_epipolar_x, left_epipolar_y, 'r');
    plot(left_x(i), left_y(i), '*');
    
    % Getting the epipolar line on the RIGHT image (l_right = F x_left)
    % as a projection of the left point using the fundamental matrix
    left_P = [left_x(i); left_y(i); 1];
    right_P = F*left_P; % right epipolar line
    % Using the eqn of line: ax+by+c=0; y = (-c-ax)/b
    right_epipolar_x = 1:n;
    right_epipolar_y = (-right_P(3)-right_P(1)*right_epipolar_x)/right_P(2);
    
    % plot on right image
    subplot(1,2,2);
    plot(right_epipolar_x, right_epipolar_y, 'g');
    plot(right_x(i), right_y(i), '*');
    
end


drawnow;




%%
% https://uk.mathworks.com/help/vision/ref/epipolarline.html
% https://uk.mathworks.com/help/vision/ref/showmatchedfeatures.html

I1 = imrotate(imread('IMG_7934.jpg'),270);
I2 = imrotate(imread('IMG_7933.jpg'),270);
figure;
showMatchedFeatures(I1,I2,xL,xR,'montage','Parent',axes);
%% MATLAB FUNCTION
% inliers in first image
%I1 = imread('IMG_7934.jpg');
figure; 
subplot(121);
imshow(I1); 
title('Inliers and Epipolar Lines in First Image'); hold on;
plot(xL(inliers,1),xL(inliers,2),'go')

% epipolar lines in first image
epiLines = epipolarLine(fNorm8Point',xR(inliers,:));

%Compute the intersection points of the lines and the image border.
points = lineToBorderPoints(epiLines,size(I1));

%Show the epipolar lines in the first image
line(points(:,[1,3])',points(:,[2,4])');

%Show the inliers in the second image.
%I2 = imread('IMG_7933.jpg');
subplot(122); 
imshow(I2);
title('Inliers and Epipolar Lines in Second Image'); hold on;
plot(xR(inliers,1),xR(inliers,2),'go')


%Compute and show the epipolar lines in the second image.
epiLines = epipolarLine(fNorm8Point,xL(inliers,:));
points = lineToBorderPoints(epiLines,size(I2));
line(points(:,[1,3])',points(:,[2,4])');
truesize;

%%
% figure(1)
% imshow(I1)
% hold on
% figure(2)
% imshow(I2)
% hold on
% VisualizeMatches(xL,xR, fNorm8Point)
