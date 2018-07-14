% read the data
data=csvread('side.csv',1,1,[1 1 320 240]);
max=maxfun(data);
dataset=data/max;
level=graythresh(dataset);
t2=3*average(data)-2*median(data);
t=level*max;
b=data>t2;
imshow(b);
title('real image');
c=mat2cell(b,[25 25 25 25 25 25 25 25 25 25 25 25 20],[25 25 25 25 25 25 25 25 25 15]);
% here cells are 13X10
% so ineed to have a for loop to do the same for all cells and merge them
% back
for l=1:13
    for m=1:10
%         edge the required cell
          c{l,m}=edge(c{l,m});
%           dialating the cell
          c{l,m}=imdilate(c{l,m},strel('disk',3));
%           back to thinning          
          c{l,m} = bwmorph(c{l,m},'thin',inf);
    end
end
% cells and back to mat
a=cell2mat(c);
% figure;
% imshow(a);
% title('refined edge');
d=a|b;
% figure
% imshow(d);
% title('OR logic');
% figure;
fil=imfill(d,'holes');
% imshow(fil);
% title('Filled Image');
mor=bwmorph(fil,'spur',inf);
mor=bwmorph(mor,'bridge',inf);
b=mor;
b=b-edge(b);
% b=b-edge(b);
% b=b-edge(b);
% b=b-edge(b);


figure;
imshow(b);

