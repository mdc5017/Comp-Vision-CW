% Task 4a
% M Paz Cardona

% http://ros-developer.com/2017/12/26/finding-homography-matrix-using-singular-value-decomposition-and-ransac-in-opencv-and-matlab/

cd('C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 4\4a')
%% Part a

T = readtable('Corresponding_keypoints_4a.xlsx');

% remove rows and cols
col_ind = [1:21,24:25,28:31];
T(:, col_ind) = [];
T(1:2,:) = [];
%% 
% select "good" keypoints
% row_ind = [1:14,33:48,58:59];
%row_ind = [1:36,41:59];
row_ind = [1:30,41:59];
T(row_ind, :) = [];
%%

xL = (table2array(T(:,3:4))); %8019
xR = (table2array(T(:,1:2))); %8020

%%

A = [xL(1,1) xL(1,2) 1 0 0 0 -xR(1,1).*xL(1,1) -xR(1,1).*xL(1,2) -xR(1,1);
      0 0 0 xL(1,1) xL(1,2) 1 -xL(1,1).*xR(1,2) -xL(1,2).*xR(1,2) -xR(1,2);
      xL(2,1) xL(2,2) 1 0 0 0 -xR(2,1).*xL(2,1) -xR(2,1).*xL(2,2) -xR(2,1);
      0 0 0 xL(2,1) xL(2,2) 1 -xL(2,1).*xR(2,2) -xL(2,2).*xR(2,2) -xR(2,2);
      xL(3,1) xL(3,2) 1 0 0 0 -xR(3,1).*xL(3,1) -xR(3,1).*xL(3,2) -xR(3,1);
      0 0 0 xL(3,1) xL(3,2) 1 -xL(3,1).*xR(3,2) -xL(3,2).*xR(3,2) -xR(3,2);
      xL(4,1) xL(4,2) 1 0 0 0 -xR(4,1).*xL(4,1) -xR(4,1).*xL(4,2) -xR(4,1);
      0 0 0 xL(4,1) xL(4,2) 1 -xL(4,1).*xR(4,2) -xL(4,2).*xR(4,2) -xR(4,2)];

[U,S,V] = svd(A);

h = V(:,9) ./ V(9,9);
h = reshape(h, [3,3]);


%% visualization

I1 = imrotate(imread('IMG_8019.jpg'),270);
I2 = imrotate(imread('IMG_8020.jpg'),270);

T1 = readtable('Corresponding_keypoints_4a.xlsx');

% remove rows and cols
col_ind = [1:21,24:25,28:31];
T1(:, col_ind) = [];
T1(1:2,:) = [];
rows = [1:15,17, 21:29,33:36,42:49,53:59];
T1(rows,:)=[];
p1 = (table2array(T1(:,3:4))); %8019
p2 = (table2array(T1(:,1:2))); % 8020

figure;
showMatchedFeatures(I1,I2,p1,p2,'montage','Parent',axes);

