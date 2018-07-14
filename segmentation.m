% FOR THRESHOLDING
I = imread('2.jpg');
I1=rgb2gray(I);
I2=thresholding(I1);
cc=bwconncomp (I2,26);
n=cc.NumObjects;
subplot(2,1,1)
imshow(I1);
subplot(2,1,2)
imshow(I2);

