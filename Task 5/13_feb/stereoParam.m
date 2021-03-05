% StereoParams

load('leftParam.mat')
cameraParameters1= cameraParams;


load('rightParam.mat')
cameraParameters2 = cameraParams;

rotationOfCamera2 = zeros(3,3);
translationOfCamera2 = [55 0 0];

stereoParams = stereoParameters(cameraParameters1,cameraParameters2,rotationOfCamera2,translationOfCamera2);
save('stereoParams.mat','stereoParams')