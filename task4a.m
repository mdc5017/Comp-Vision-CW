% Task 4a
% M Paz Cardona

cd('C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 4\4a')
%% Part a

T = readtable('Corresponding_keypoints_4a.xlsx');

% remove rows and cols
col_ind = [1:21,24:25,28:31];
T(:, col_ind) = [];
T(1:2,:) = [];
%% 
% select "good" keypoints
row_ind = [1:14,33:48,58:59];
T(row_ind, :) = [];
%%

xL = round(table2array(T(:,3:4))); %8019
xR = round(table2array(T(:,1:2))); %8020
z = zeros(27,1);
one = ones(27,1);

A = [xR(:,1) xR(:,2) one z z z -xL(:,1).*xR(:,1) -xL(:,1).*xR(:,2) -xL(:,1)];

[U,S,V] = svd(A);

h = V(:,9) ./ V(9,9);
h = reshape(h, [3,3]);

