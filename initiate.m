function A=initiate(filename)
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
d1=data1>T1;
d2=data2>T2;
A(1:160,:)=d1(1:160,:);
A(161:320,:)=d2;
% A=d1;
A=imfill(A,'holes');
end