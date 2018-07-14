% extraction of csv data to matlab
data=csvread('front.csv',1,1,[1 1 320 240]);

% converting it to an intensity gray scal image
data1=(data-minfun(data))/(maxfun(data)-minfun(data));
imshow(data1);
% thresholding level
T=3*average(data1)-2*median(data1);

% thresholding
A=data1>T;

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
X = sgolayfilt(x, polynomialOrder, windowWidth);
Y = sgolayfilt(y, polynomialOrder, windowWidth);

% blob analysis for centroid
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,A);
p1=do_points_left(X,Y,C);
p2=do_right_points(X,Y,C);

% averaging the position of the points
% WRT the centroid

avg(:,1)=(abs(p1(:,1)-C(1,1))+abs(p2(:,1)-C(1,1)))/2;
avg(:,2)=(abs(p1(:,2)-C(1,2))+abs(p2(:,2)-C(1,2)))/2;
p_1(:,1)=C(1,1)-avg(:,1);
p_1(:,2)=C(1,2)-avg(:,2);
p_2(:,1)=C(1,1)+avg(:,1);
p_2(:,2)=C(1,2)-avg(:,2);

% imshow(A);
% hold on
% plot(p1(:,1),p1(:,2),'r*');
% plot(p2(:,1),p2(:,2),'r*');
% plot(C(1,1),C(1,2),'r*');
% plot(p_1(:,1),p_1(:,2),'b*');
% plot(p_2(:,1),p_2(:,2),'b*');
 
