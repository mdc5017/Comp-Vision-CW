function [matched_points1, matched_points2] = Keypoint_Extraction_Matching(img1, img2)
    
    %Read the images
    I1 = rgb2gray(imread(img1));
    I2 = rgb2gray(imread(img2));
    I1 = imrotate(I1, -90);
    I2 = imrotate(I2, -90);
    %Find the corners
    points1 = detectSURFFeatures(I1);
    points2 = detectSURFFeatures(I2);
    
    [features1, valid_points1] = extractFeatures(I1, points1);
    [features2, valid_points2] = extractFeatures(I2, points2);
    
    indexPairs = matchFeatures(features1, features2);
    
    matched_points1 = valid_points1(indexPairs(:, 1), :);
    matched_points2 = valid_points2(indexPairs(:, 2), :);
    
    figure; showMatchedFeatures(I1, I2, matched_points1, matched_points2);
end