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
cropped=imcrop(b,[105 30 25 25]);
imshow(cropped);
edg=edge(cropped);
figure;
imshow(edg);
dilatedImage = imdilate(edg,strel('diamond',4));
% % figure;
% imshow(dilatedImage);
thinedImage = bwmorph(dilatedImage,'thin',inf);
figure
imshow(thinedImage);
% or both cropped and thinedimage
cropped=or(cropped,thinedImage);
% figure
% imshow(cropped);
new=zeros(320,240);
for i=30:55
    for j=105:130
        new(i,j)=cropped(i-29,j-104);
    end
end
figure
imshow(new);
% b(144:166,91:116)=cropped;
new2=new | b;
imshow(new2);
edg2=edge(new2);
% edg2=imfill(edg2,'holes');
% imshow(edg2);
edg2=bwmorph(edg2,'bridge',inf);
imshow(imfill(edg2,'holes'));