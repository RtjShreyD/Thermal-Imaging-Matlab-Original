max1=maxfun(data);
max2=maxfun(data1);
min1=minfun(data);
min2=minfun(data1);
dataset1=(data-min1*ones(320,240))/(max1-min1);
dataset2=(data1-min2*ones(320,240))/(max2-min2);
level1=graythresh(dataset1);
level2=graythresh(dataset2);
t2=3*average(dataset1)-2*median(dataset1);
t_2=3*average(dataset2)-2*median(dataset2);
t=level1;
t_=level2;
b1=dataset1>t2;
b2=dataset2>t_2;
fld1=imfill(b1,'holes');
imshow(fld1);
figure;
fld2=imfill(b2,'holes');
imshow(fld2);

% figure;
% imshow(b1);
% 
% edg1=edge(b1,'canny');
% figure;
% imshow(edg1);
% edg1=edge(b1,'log');
% figure;
% imshow(edg1);