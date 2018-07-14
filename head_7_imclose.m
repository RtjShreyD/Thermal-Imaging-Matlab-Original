% read the data
data=csvread('front.csv',1,1,[1 1 320 240]);
max=maxfun(data);
dataset=data/max;
level=graythresh(dataset);
t2=3*average(data)-2*median(data);
t=level*max;
b=data>t2;
figure;
imshow(b);
cropped=imcrop(b,[105 30 25 25]);
% figure;
% imshow(cropped);
se = strel('disk',70);
closeBW = imclose(cropped,se);
figure;
imshow(closeBW);
