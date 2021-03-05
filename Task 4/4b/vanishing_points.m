% https://github.com/engmubarak48/Vanishing-point-detection/blob/master/VPD.m

close all
clear
clc
% Vanishing Point Detection By ---Jama Hussein Mohamud----


%% Read the Image
image=imrotate(imread('IMG_8321.jpg'),-90);
%% 
L = 0;      % number of pixels to be added around the image
ED = 0.8;   % Edge Threshold
ML = 50;    % MinLength of HoughPeaks
%%
Addpixel = padarray(image,[L L],255);
figure(1), imshow(Addpixel);title('Original image with pixels added around the image');
%%
%Convert the image to Grayscale
I=rgb2gray(Addpixel);
figure(2),imshow(I);title('Grayscale Image');

%%
% Thresholding
threshold=80;  
I(I<threshold)=0;
I(I>=threshold)=1; 
%%
%Edge Detection
edge=edge(I,'canny', ED);
figure(3),imshow(edge);title('detected edge image with appropriate threshold value');

%% Apply Hough Transform
[H,theta,rho] = hough(edge);
figure(4), imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,'InitialMagnification','fit');
title('Hough transform');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot)

%% Find the Hough peaks 
P = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));
p_x = theta(P(:,2));
p_y = rho(P(:,1));
plot(p_x,p_y,'s','color','black');

%% Obtain the lines from Hough Lines
lines = houghlines(edge,theta,rho,P,'FillGap',5,'MinLength',ML);
figure(5), imshow(Addpixel), hold on

% Plot vanishing point from Hough lines =[ Intersection of the lines] 
for k = 1:length(lines)
lk = [lines(k).point1; lines(k).point2];
 slope = @(line) (line(2,2) - line(1,2))/(line(2,1) - line(1,1));
   intercept = @(line,m) line(1,2) - m*line(1,1);
   s = slope(lk);
   in = intercept(lk, s);
   x = linspace(0, length(edge));
   y = s*x + in;
   plot(x ,y ,'LineWidth',1.3,'Color','yellow'); hold on
end


yline(223.165, '--', 'LineWidth', 1, 'Color', 'blue'); hold on;
yline(590.464, '--', 'LineWidth', 1, 'Color', 'blue'); hold on;
yline(406.8145, 'LineWidth', 1, 'Color', 'blue'); hold on;
plot(1629.09, 406.8145, 'Marker','p','MarkerSize',10, 'MarkerFaceColor','red')