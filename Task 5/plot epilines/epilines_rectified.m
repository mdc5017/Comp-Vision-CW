
cd('C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\plot epilines')

load('rectified_good.mat');
I1 = I1Rect;
I2 = I2Rect;

T = table2array(readtable('Corresponding_keypoints.xlsx'));


%remove rows and cols not needed
T(:,1:13) = [];
T(24:28,:) = [];
row_ind = [7,9,11,14:16,18,22];
T(row_ind,:) = [];




matchedPoints1 = T(:,1:2); 
matchedPoints2 = T(:,3:4); 
%%
%load stereoPointPairs
[fLMedS,inliers] = estimateFundamentalMatrix(matchedPoints1,...
    matchedPoints2,'NumTrials',4000);

figure; 
subplot(121);
imshow(I1Rect); 
title('Inliers and Epipolar Lines in First Image'); hold on;
plot(matchedPoints1(inliers,1),matchedPoints1(inliers,2),'go')
epiLines = epipolarLine(fLMedS',matchedPoints2(inliers,:));
points = lineToBorderPoints(epiLines,size(I1Rect));
line(points(:,[1,3])',points(:,[2,4])');

subplot(122); 
imshow(I2Rect);
title('Inliers and Epipolar Lines in Second Image'); hold on;
plot(matchedPoints2(inliers,1),matchedPoints2(inliers,2),'go')

epiLines = epipolarLine(fLMedS,matchedPoints1(inliers,:));
points = lineToBorderPoints(epiLines,size(I2));
line(points(:,[1,3])',points(:,[2,4])');
truesize;

%%
figure;
showMatchedFeatures(I1Rect,I2Rect,matchedPoints1,matchedPoints2,'montage',...
    'PlotOptions', {'ro','g+','y-'}) 

%%
xL = matchedPoints1;
xR = matchedPoints2;

figure;
colors = ['r', 'g', 'b', 'c', 'y', 'm', 'k', 'w'];

stackedImage = cat(2, I1Rect, I2Rect); % Places the two images side by side
imshow(stackedImage);
width = size(I1Rect, 2)+size(I2Rect,2);
hold on;
numPoints = size(xL, 1); % points2 must have same # of points
% Note, we must offset by the width of the image
for i = 1 : numPoints
    color = colors(mod(i, 8)+1);
    plot(xL(i, 1), xL(i, 2), 'co', xR(i, 1) + size(I1Rect,2), ...
         xR(i, 2), 'co');
    line1 = line([xL(i, 1) xR(i, 1) + width], [xL(i, 2) xR(i, 2)],...
         'Color', 'yellow', 'Linewidth', 1.25);
     
    line2 = line([xL(i, 1) xR(i, 1) - width], [xL(i, 2) xR(i, 2)],...
         'Color', 'yellow', 'Linewidth', 1.25);
     
end
