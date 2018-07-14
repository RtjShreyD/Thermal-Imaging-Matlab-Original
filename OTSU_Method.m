%implementing for 2data
I=thresholding(data,86);
[r,c]=size(data);
max=maxfun(data);
dataset=data/max;
I4=thresholding(dataset,86/max);
imshow(I4);
figure;
% convert into [0,1]range

[level,EM]=graythresh(dataset);
I1=imbinarize(dataset,level);
imshow(I1);
% Seems foot was distorted distorted
figure;
% diff approach for o to 1
a=maxfun(data);
b=minfun(data);
mod=b*ones(r,c);
mod=(data-mod)/(a-b);
[level2,EM2]=graythresh(mod);
I2=imbinarize(mod,level2);
imshow(I2);
