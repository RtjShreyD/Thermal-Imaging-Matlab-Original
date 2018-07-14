% read the data
data=csvread('front.csv',1,1,[1 1 320 240]);
max=maxfun(data);
dataset=data/max;
level=graythresh(dataset);
t2=3*average(data)-2*median(data);
t=level*max;
b=data>t2;
imshow(b);
% b=imsmooth(b,105,30,25,25,4);
% b=imsmooth(b,105,30,25,25,4);

% b=imsmooth(b,105,30,25,25,4);
% b=imsmooth(b,105,30,25,25,4);
% b=imsmooth(b,105,30,25,25,4);
% b=imsmooth(b,105,30,25,25,4);
b=imsmooth(b,105,30,30,30,4);
% b=imsmooth(b,105,30,30,30,4);
% b=imsmooth(b,144,91,25,25,3);
b=imsmooth(b,144,91,25,25,3);
% b=imsmooth(b,92,150,30,30,4);
b=imsmooth(b,92,150,30,30,4);
b=bwmorph(b,'spur');
figure;
imshow(b);
c=imfill(b,'holes');
% c=c-b;
figure;
imshow(c);
