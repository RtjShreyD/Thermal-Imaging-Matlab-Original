% x , y are the boundaries of the blob
% X,Y is smooth C is centroid ,crotch is the level of crotch and hiplevel
% is the height in pixel 
% [lok,PP]=new_right_points(a1,X1,Y1,x1,y1,C,cro,hiplevel);
function [location,p]=few_right_points(a)
[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
C=step(blob,a);
N=size(X,1);
[~,c]=maxfun2(X);
% for neck
% from left to right most end traversing to get the neck point 
% here 'c' is the right end and 1 is left end
% from this we get the right corner edge point by using that for loop
% get the maximum peak ie., the bending point
new1=zeros(c,1);
for i=1:c-1
    if(X(i)>C(1,1) && Y(i)<C(1,2))
        new1(i)=i;
    end
end
k1=find(new1);
x1=x(k1(1):k1(end));
y1=y(k1(1):k1(end));
[~,l1]=findpeaks(-x1);
% l1 consists of locations of the peaks
p(1,1)=x1(l1(1));
p(1,2)=y1(l1(1));
% and locations are saved in location

location(1)=k1(1)+l1(1)-1;

% for sholder
% from neck right point to the right max point in the for loop
x2=x1(l1(1):end);
y2=y1(l1(1):end);
der2=zeros(size(x2,1)-1,1);
% der2 is an array of slope form neck to end
% to find the minimum slope point
for i=1:size(x2,1)-1
    der2(i)=(y2(i)-y2(i+1))/(x2(i)-x2(i+1));
end
[~,l2]=findpeaks(-der2);
% l2 has the location for the minimum slope inthe curve from neck to get
% HPS

p(2,1)=x2(l2(1));
p(2,2)=y2(l2(1));
location(2)=location(1)-1+l2(1);

% armpit point
% To get the armpit point we have to traverse from maximum of X to the
% again traverse to get into the armpit to centroid location in for loop
% x3 , y3 consists those locations and now we have to find out the slope of
% 1 peaks so we have to get the peak in first peak
% der3 has the array of slope of every index
new3=zeros(N-c,1);
for i=c+1:N
    if(X(i)>C(1,1) && Y(i)<C(1,2))
        new3(i)=i;
    end
end
k3=find(new3);
x3=X(k3(1):k3(end));
y3=Y(k3(1):k3(end));
[~,l3]=findpeaks(-y3);
der3=zeros(size(y3,1)-l3(end)-1,1);
for i=l3(end):size(y3,1)-1
     der3(i-l3(end)+1)=(y3(i+1)-y3(i))/(x3(i+1)-x3(i))+1;
end
der3=abs(der3);
% minimum of the slope
[~,l_3]=minfun2(der3);
p(3,1)=x3(l3(end)+l_3);
p(3,2)=y3(l3(end)+l_3);
location(3)=l3(end)+l_3+k3(1)-1;

end