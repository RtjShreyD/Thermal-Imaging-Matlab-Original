function p=findneck(X,Y)
[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
C=step(blob,a);
% cro is the index in 
N=size(X,1);
N2=round(N/2);
% neck point
new1=zeros(N2,1);
for i=1:N2
    if(C(1,1)>X(i) && C(1,2)>Y(i))
        new1(i)=i;
    end
end
k1=find(new1);
x1=X(k1(1):k1(end));
y1=Y(k1(1):k1(end));
[~,loc]=findpeaks(x1);
p(1,1)=x1(loc(end));
p(1,2)=y1(loc(end));
% right neck point
[~,c]=maxfun2(X);
% for neck
% from left to right most end traversing to get the neck point 
% here 'c' is the right end and 1 is left end
% from this we get the right corner edge point by using that for loop
% get the maximum peak ie., the bending point
new2=zeros(c,1);
for i=1:c-1
    if(X(i)>C(1,1) && Y(i)<C(1,2))
        new2(i)=i;
    end
end
k2=find(new2);
x2=X(k2(1):k1(end));
y2=Y(k2(1):k1(end));
[~,l2]=findpeaks(-x2);
% l1 consists of locations of the peaks
p(2,1)=x2(l2(1));
p(2,2)=y2(l2(1));
end