% extraction of csv data to matlab
data=csvread('front.csv',1,1,[1 1 320 240]);

% converting it to an intensity gray scal image
data=(data-minfun(data))/(maxfun(data)-minfun(data));

% thresholding level
T=3*average(data)-2*median(data);

% thresholding
A=data>T;

% filling unwanted holes
A=imfill(A,'holes');
% imshow(A);

% finding the boundaries
bound=bwboundaries(A);
B=bound{1,1};
new=B;
x=new(:,2);
y=new(:,1);

% smoothening the boundaries using SG filter
windowWidth = 25;
polynomialOrder = 3;
smoothX = sgolayfilt(x, polynomialOrder, windowWidth);
smoothY = sgolayfilt(y, polynomialOrder, windowWidth);

% blob analysis for centroid
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
centroid=step(blob,A);

imshow(A);
hold on
plot(smoothX,smoothY,'b-','linewidth',2);
point = do_right_points(smoothX,smoothY,centroid);
plot(point(:,1),point(:,2),'r*');