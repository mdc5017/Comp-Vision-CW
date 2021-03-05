%% Depth map estimation from stereo images
%STEPS TO MAKE THE DEPTH MAP
%Step 1: rectify the images to remove distortions and horizontally align the
%image pairs ---> this reduces the search for corresponding points to 1
%dimension and makes the process a lot faster. 

%Step 2: Create a disparity map by matching every pixel in the left image
%with the corresponding pixel in right image. computer the distance between
%the pixel values(this is the disparity)

%With the help of the disparity map and the camera parameters, we can
%reconstruct a 3D version of the image in a point cloud. 

%Index into the depth of the point cloud to create and apply a mask
clc; clear all; close all;
%% Section to rectify images

%Load stereoParameters
load("stereoParamsREDCAMTOG.mat");

%Read in the stereo pair of images
InL = imread('C:\Year_4_Courses\Computer_Vision_and_Pattern_Recognition\reduLeft\IMG_8266_r.JPG'); 
InR = imread('C:\Year_4_Courses\Computer_Vision_and_Pattern_Recognition\reduRight\IMG_8293_r.JPG'); 

%Display the images before rectification
figure
subplot(2,1,1)
imshowpair(InL, InR)
title('Unrectified Images')

%rectify the images
[OutL, OutR] = rectifyStereoImages(InL, InR, stereoParams);

%Display the images after rectification
figure
subplot(2,1,1)
imshowpair(OutL, OutR)
title('Rectified Images')

%% Section to generate disparity map - map of pixel displacements between the left and right images
 
%Generate disparity map
disparityMap = disparity(rgb2gray(I1Rect), rgb2gray(I2Rect));

%Visualize the disparity map - note, the image will seem binary as the
%standard disparity map tends to have high contrast, which makes gradients
%less apparent.
figure
imshow(disparityMap)
title('Disparity Map')

%Make adjustments to the image contrasts
figure
imshow(disparityMap, [0, 64])
title('Disparity Map with modified image contrast')

%Add some color by changing the color map
colormap jet

%Add a colorbar to get some perspective - pixels closest 
colorbar
%% Section to reconstruct the scene

%Generate a point cloud
points3d = reconstructScene(disparityMap, stereoParams);
points3d = points3d./1000;

ptCloud = pointCloud(points3d, 'Color', OutL);
%Display point cloud
pcshow(ptCloud)
