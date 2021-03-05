% Auto-generated by cameraCalibrator app on 13-Feb-2021
%-------------------------------------------------------


% Define images to process
imageFileNames = {'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8268.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8269.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8270.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8271.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8272.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8273.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8275.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8276.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8277.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8278.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8279.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8280.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8282.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8283.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8284.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8286.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8287.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8288.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8289.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8291.JPG',...
    'C:\Users\mpazc\OneDrive\Escritorio\Imperial\Year 4\Computer Vision & Pattern Recognition\Comp Vision CW\Task 5\13_feb\left_camera\IMG_8292.JPG',...
    };
% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 4.150000e+01;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')