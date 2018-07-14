filename='nikstr.csv';
data=csvread(filename,1,1,[1 1 640 480]);
% data=csvread(filename,1,1,[1 1 320 240]);
data1=data;
data1=(data1-minfun(data1))/(maxfun(data1)-minfun(data1));
t=imhist(data1);
% imhist(data1);
% [~,loc]=maxfun2(t);
smoothened=sgolayfilt(t,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);
smoothened=sgolayfilt(smoothened,3,45);

[g1,g2]=findpeaks(-smoothened);
figure
imshow(data1>g2(1)/255);
% figure
% imshow(data1);
% figure
% plot(t);
% figure
% plot(smoothened);
% figure
% figure
% plot(diff);
% [~,loc]=maxfun2(t);
% g=t(loc:77);

% [m,k]=minfun2(g);
% pic=data1>(k/455);
% imshow(data1>g2(1)/455);
% plot(t);