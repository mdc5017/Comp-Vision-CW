% Task 4b - epipolar lines
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

%% Automatic keypoints

T = readtable('Task4.xlsx');
T(1:2,:) = [];

xL = (table2array(T(:,6:7))); %7933
xR = (table2array(T(:,8:9))); %7934
%%

[fNorm8Point,inliers]  = estimateFundamentalMatrix(xL,xR, 'Method', 'RANSAC');


%%
% https://github.com/karan9nov/epipolar-geometry/blob/master/newScript.m
x1 = xL;
x2 = xR;
homo_x2 = [x2, ones(8,1,'double')];
homo_x1 = [x1, ones(8,1,'double')];

orig = imrotate(imread('IMG_7934.jpg'),270);
imshow(orig);
tr = imrotate(imread('IMG_7933.jpg'),270);
imshow(tr)

%Display the second image
imshow(tr);
hold on;

%Plot the taken points on the image
plot(x2(inliers,1),x2(inliers,2),'go')

%Find the epipolar lines
epiLines1 = [F * homo_x1']';
points = lineToBorderPoints(epiLines1,size(tr));

%Plot the epipolar lines on the image
line(points(:,[1,3])',points(:,[2,4])');
truesize;

%Find the epipole using the formula
[D1,E1] =eigs(F*F');
e1calculated = D1(:,1)./D1(3,1);

%I found that the epipole lies in the image itself, hence I obeserved the values from the image. 
e1observed  = ginput(1);
e1observed = [e1observed 1]';

%Find the difference in observed and calculated epipoles
error1 = e1calculated - e1observed;

%Display the first image
imshow(orig);
hold on;

%Plot the taken points on the image
plot(x1(inliers,1),x1(inliers,2),'go')

%Plot the
epiLines2 = homo_x2 * F;
points = lineToBorderPoints(epiLines2,size(tr));

%Plot the epipolar lines on the image
line(points(:,[1,3])',points(:,[2,4])');
truesize;

%Find the epipole using the formula
[D2,E2] =eig(F'*F);
e2calculated = D2(:,1)./D2(3,1);

%I found that the epipole lies in the image itself, hence I obeserved the values from the image. 
e2observed  = ginput(1);
e2observed = [e2observed 1]';

%Find the difference in observed and calculated epipoles
error2 = e2calculated - e2observed;