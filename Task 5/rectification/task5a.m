%% Rectifying the stereo images
clc; clear all; close all;

I1 = imread("IMG_8201.jpg");
I2 = imread("IMG_8202.jpg");

I1 = imrotate(I1, -90);
I2 = imrotate(I2, -90);

load("fNorm8Point.mat");
data = xlsread("Corresponding_keypoints_5a", "Stereo_Images");
inliers1 = data(:, 1:2);
inliers2 = data(:, 3:4);

[t1, t2] = estimateUncalibratedRectification(f, inliers1, inliers2, [size(I1, 1) size(I1, 2)]);

tform1 = projective2d(t1);
tform2 = projective2d(t2);

[I1rect, I2rect] = rectifyStereoImages(I1,I2,t1,t2);