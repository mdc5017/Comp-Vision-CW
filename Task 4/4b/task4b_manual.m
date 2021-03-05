%% Task 4b
% M Paz Cardona

% Manual

cd('C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 4\4b')


num = xlsread('Corresponding_keypoints_4b.xlsx',2);

% remove rows and cols not needed
col_ind = [1:19,24:35];
num(:, col_ind) = [];
num(1:2,:) = [];
row_ind = [1:36,42:49,53:59];
num(row_ind, :) = [];
%%
% keypoints 37-41;50-52
xR = num(:,1:2); % 7933
xL = num(:,3:4); % 7934
%%
% http://www.cse.psu.edu/~rtc12/CSE486/lecture20_6pp.pdf

A = [xL(1,1).*xR(1,1) xL(1,1).*xR(1,2) xL(1,1) xL(1,2).*xR(1,1) xL(1,2).*xR(1,2) xL(1,2) xR(1,1) xR(1,2) 1;
    xL(2,1).*xR(2,1) xL(2,1).*xR(2,2) xL(2,1) xL(2,2).*xR(2,1) xL(2,2).*xR(2,2) xL(2,2) xR(2,1) xR(2,2) 1;
    xL(3,1).*xR(3,1) xL(3,1).*xR(3,2) xL(3,1) xL(3,2).*xR(3,1) xL(3,2).*xR(3,2) xL(3,2) xR(3,1) xR(3,2) 1;
    xL(4,1).*xR(4,1) xL(4,1).*xR(4,2) xL(4,1) xL(4,2).*xR(4,1) xL(4,2).*xR(4,2) xL(4,2) xR(4,1) xR(4,2) 1;
    xL(5,1).*xR(5,1) xL(5,1).*xR(5,2) xL(5,1) xL(5,2).*xR(5,1) xL(5,2).*xR(5,2) xL(5,2) xR(5,1) xR(5,2) 1;
    xL(6,1).*xR(6,1) xL(6,1).*xR(6,2) xL(6,1) xL(6,2).*xR(6,1) xL(6,2).*xR(6,2) xL(6,2) xR(6,1) xR(6,2) 1;
    xL(7,1).*xR(7,1) xL(7,1).*xR(7,2) xL(7,1) xL(7,2).*xR(7,1) xL(7,2).*xR(7,2) xL(7,2) xR(7,1) xR(7,2) 1;
    xL(8,1).*xR(8,1) xL(8,1).*xR(8,2) xL(8,1) xL(8,2).*xR(8,1) xL(8,2).*xR(8,2) xL(8,2) xR(8,1) xR(8,2) 1];

[U,S,V] = svd(A);

f = V(:,9) ./ V(9,9);
f = reshape(f, [3,3]);