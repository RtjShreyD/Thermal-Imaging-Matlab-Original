clc
close all
I=imread('2.jpg');
I=rgb2gray(I);
I2=thresholding(I);
regions = detectMSERFeatures(I);
% Visualize MSER regions which are described by pixel lists stored inside the returned 'regions' object.
figure; imshow(I2); hold on;
plot(regions,'showPixelList',true,'showEllipses',false);