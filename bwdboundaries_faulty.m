% read the data
data=csvread('front.csv',1,1,[1 1 320 240]);
max=maxfun(data);
dataset=data/max;
level=graythresh(dataset);
t2=3*average(data)-2*median(data);
t=level*max;
b=data>t;
figure;
 imshow(b);
 
% get edgesfigure;
edg=edge(b);
% figure;
% imshow(edg);

% smoothing the edge

% dilatedImage = imdilate(edg,strel('disk',3));
 thinedImage = bwmorph(edg,'thin',inf);

% fill the patch

remvdlobes=imfill(thinedImage,'holes');
figure;
imshow(remvdlobes);

% get boundaries 

% B=bwboundaries(remvdlobes);
% figure;
% imshow(label2rgb(remvdlobes, @jet, [.5 .5 .5]))
% hold on
% boundary = B{1};
% plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)

