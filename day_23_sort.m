filename='7.1.csv';
data=csvread(filename,1,1,[1 1 320 240]);
data1=data;
data2=data(161:320,:);
data1=(data1-minfun(data1))/(maxfun(data1)-minfun(data1));
data2=(data2-minfun(data2))/(maxfun(data2)-minfun(data2));
T1=3*average(data1)-2*median(data1);
T2=3*average(data2)-2*median(data2);
% figure;
% imshow(data1);
% thresholding
t=graythresh(data1);
d1=data1>0.2;
% d2=data2>T2;
A=d1;
% A(161:320,:)=d2;

% imshow(A);
t=imhist(data1);
plot(t);
% A=imfill(A,'holes');
% [X1,Y1,x1,y1]=mysmooth(A);
% imshow(A);
% hold on
% plot(X1,Y1,'b-','linewidth',2);
