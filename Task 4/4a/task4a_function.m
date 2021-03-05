% Task 4a with built-in MATLAB function

cd('C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 4\4a')
%% Part a
% https://uk.mathworks.com/help/vision/ref/estimategeometrictransform2d.html
T = readtable('Corresponding_keypoints_4a.xlsx');

% remove rows and cols
col_ind = [1:21,24:25,28:31];
T(:, col_ind) = [];
T(1:2,:) = [];


% select "good" keypoints
% row_ind = [1:14,33:48,58:59];
row_ind = [1:36,41:59];
T(row_ind, :) = [];
%%

xL = (table2array(T(:,3:4))); %8019
xR = (table2array(T(:,1:2))); %8020


%% Automatic keypoints

T = readtable('Task4.xlsx');
T(1:2,:) = [];
T(152:155,:) = [];

xL = (table2array(T(:,1:2))); %8019
xR = (table2array(T(:,3:4))); %8020
%% 

h_function = estimateGeometricTransform2D(xL, xR, 'projective');
h_function.T