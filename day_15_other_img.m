% extraction of csv data to matlab
data=csvread('22.csv',1,1,[1 1 320 240]);
data1=data;
data2=data(161:320,:);
data1=(data1-minfun(data1))/(maxfun(data1)-minfun(data1));
data2=(data2-minfun(data2))/(maxfun(data2)-minfun(data2));
T1=3*average(data1)-2*median(data1);
T2=3*average(data2)-2*median(data2);
% imshow(data1);
figure
% thresholding
d1=data1>T1;
d2=data2>T2;
A(1:160,:)=d1(1:160,:);
A(161:320,:)=d2;
% A=d1;
% filling unwanted holes
A=imfill(A,'holes');
imshow(A);
hold on
% finding the boundaries
bound=bwboundaries(A);
B=bound{1,1};
new=B;
x=new(:,2);
y=new(:,1);
% plot(x,y,'b-');
% smoothening the boundaries using SG filter
windowWidth = 25;
polynomialOrder = 3;
X = sgolayfilt(x, polynomialOrder, windowWidth);
Y = sgolayfilt(y, polynomialOrder, windowWidth);

plot(X,Y,'b-');
% blob analysis for centroid
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,A);
plot(C(1,1),C(1,2),'r*');
%left points
p1=new_left_points(X,Y,C);
plot(p1(:,1),p1(:,2),'r*');
%% right points
p2=do_right_points(X,Y,C);

%% averaging the position of the points
% WRT the centroid

avg(:,1)=(abs(p1(:,1)-C(1,1))+abs(p2(:,1)-C(1,1)))/2;
avg(:,2)=(abs(p1(:,2)-C(1,2))+abs(p2(:,2)-C(1,2)))/2;
p_1(:,1)=C(1,1)-avg(:,1);
p_1(:,2)=C(1,2)-avg(:,2);
p_2(:,1)=C(1,1)+avg(:,1);
p_2(:,2)=C(1,2)-avg(:,2);

imshow(A);
hold on
plot(p1(:,1),p1(:,2),'r*');
plot(p2(:,1),p2(:,2),'r*');
plot(C(1,1),C(1,2),'r*');
plot(p_1(:,1),p_1(:,2),'b*');
plot(p_2(:,1),p_2(:,2),'b*');


