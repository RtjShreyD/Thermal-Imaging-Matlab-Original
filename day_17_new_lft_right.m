% extraction of csv data to matlab
data=csvread('46_s.csv',1,1,[1 1 320 240]);
data1=data;
data2=data(161:320,:);
data1=(data1-minfun(data1))/(maxfun(data1)-minfun(data1));
data2=(data2-minfun(data2))/(maxfun(data2)-minfun(data2));
T1=3*average(data1)-2*median(data1);
T2=3*average(data2)-2*median(data2);
imshow(data1);
figure;
% thresholding
d1=data1>T1;
d2=data2>T2;
A(1:160,:)=d1(1:160,:);
A(161:320,:)=d2;
% A=d1;
A=imfill(A,'holes');
imshow(A);
hold on
bound=bwboundaries(A);
B=bound{2,1};
new=B;
x=new(:,2);
y=new(:,1);
windowWidth = 25;
polynomialOrder = 3;
X = sgolayfilt(x, polynomialOrder, windowWidth);
Y = sgolayfilt(y, polynomialOrder, windowWidth);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,A);
p1=new_right_points(X,Y,C);
p2=new_left_points(X,Y,C);
[p_1,p_2]=pointadjust(p1,p2,C);
figure
imshow(A);
hold on
plot(C(1,1),C(1,2),'r*');
plot(p1(:,1),p1(:,2),'r*');
plot(p2(:,1),p2(:,2),'r*');
plot(p_1(:,1),p_1(:,2),'b*');
plot(p_2(:,1),p_2(:,2),'b*');
plot(X,Y,'b-');
