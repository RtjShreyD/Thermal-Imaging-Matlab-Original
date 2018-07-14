max=maxfun(data);
dataset=data/max;
level=graythresh(dataset);
t2=3*average(data)-2*median(data);
t=level*max;
b=data>t2;

 imshow(b);

% get edgesfigure;

edg=edge(b);
% figure;
% imshow(edg);

% smoothing the edge

dilatedImage = imdilate(edg,strel('disk',3));
thinedImage = bwmorph(dilatedImage,'thin',inf);

% fill the patch

remvdlobes=imfill(thinedImage,'holes');
figure;
imshow(remvdlobes);

% get boundaries 

[B,L]=bwboundaries(remvdlobes);
figure;
imshow(b);
hold on
boundary = B{1};
plot(boundary(:,2), boundary(:,1), 'r')

