max=maxfun(data2);
dataset=data2/max;
level=graythresh(dataset);
t2=3*average(data2)-2*median(data2);
t=level*max;
b=data2>t2;

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
imshow(label2rgb(L, @jet, [.5 .5 .5]))
hold on
boundary = B{1};
plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)

