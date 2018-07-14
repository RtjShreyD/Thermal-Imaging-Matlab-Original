% read the data
data=csvread('front.csv',1,1,[1 1 320 240]);
max=maxfun(data);
dataset=data/max;
level=graythresh(dataset);
t2=3*average(data)-2*median(data);
t=level*max;
b=data>t2;
figure;
imshow(b);
cropped=imcrop(b,[144 91 25 25]);
% imshow(cropped);
edg=edge(cropped);
figure;
imshow(edg);
dilatedImage = imdilate(edg,strel('disk',2));
thinedImage = bwmorph(dilatedImage,'thin',inf);
figure
imshow(thinedImage);
% or both cropped and thinedimage
cropped=or(cropped,thinedImage);
figure
imshow(cropped);
new=zeros(320,240);
for i=144:169
    for j=91:116
        new(j,i)=cropped(j-90,i-143);
    end
end
figure
imshow(new);
% b(144:166,91:116)=cropped;
new2=new | b;
imshow(new2);
edg2=edge(new2);
edg2=imfill(edg2,'holes');
imshow(edg2);