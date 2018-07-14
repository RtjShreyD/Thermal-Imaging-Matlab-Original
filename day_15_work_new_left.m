% extraction of csv data to matlab
data=csvread('45.csv',1,1,[1 1 320 240]);
data1=data;
data2=data(161:320,:);
data1=(data1-minfun(data1))/(maxfun(data1)-minfun(data1));
data2=(data2-minfun(data2))/(maxfun(data2)-minfun(data2));
T1=3*average(data1)-2*median(data1);
T2=3*average(data2)-2*median(data2);

% % thresholding
d1=data1>T1;
d2=data2>T2;
A(1:160,:)=d1(1:160,:);
A(161:320,:)=d2;
A=imfill(A,'holes');
imshow(A);
hold on
bound=bwboundaries(A);
B=bound{1,1};
new=B;
x=new(:,2);
y=new(:,1);

blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,A);
plot(C(1,1),C(1,2),'r*');
windowWidth = 25;
polynomialOrder = 3;
X = sgolayfilt(x, polynomialOrder, windowWidth);
Y = sgolayfilt(y, polynomialOrder, windowWidth);
plot(X,Y,'b-'); 
N=size(X,1);
N2=round(N/2);
new1=zeros(N2,1);
for i=1:N2
    if(C(1,1)>X(i) && C(1,2)>Y(i))
        new1(i)=i;
    end
end
k1=find(new1);
x1=X(k1(1):k1(end));
y1=Y(k1(1):k1(end));
% plot(x1,y1,'p-'); 
% plot(x1);

[peak,loc]=findpeaks(x1);
p(1,1)=x1(loc);
p(1,2)=y1(loc);
% plot(p);
%  sholder point
x2=x1(1:loc(1,1));
y2=y1(1:loc(1,1));
der2=zeros(loc(1,1)-1,1);
for i=1:loc(1,1)-1
    der2(i)=(y2(i)-y2(i+1))/(x2(i)-x2(i+1));
end
der2=abs(der2);
[m2,c2]=minfun2(der2);
p(2,1)=x2(c2);
p(2,2)=y2(c2);
plot(p(:,1),p(:,2),'r*');
% armpit point
new3=zeros(N2,1);
for i=N2:N
    if(X(i)<C(1,1) && Y(i)<C(1,2))
        new3(i)=i;
    end
end
k3=find(new3);
x3=X(k3(1):k3(end));
y3=Y(k3(1):k3(end));
plot(-y3);
[peak3,loc3]=findpeaks(-y3);
der3=zeros(loc3(1)-1,1);
for j=1:loc3(1)-1
    der3(j)=((y3(j)-y3(j+1))/(x3(j)-x3(j+1)))-1;
end
der3=abs(der3);
[pk3,l3]=minfun2(der3);
p(3,1)=x3(l3);
p(3,2)=y3(l3);

plot(p(:,1),p(:,2),'r*');