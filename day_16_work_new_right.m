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
windowWidth = 25;
polynomialOrder = 3;
X = sgolayfilt(x, polynomialOrder, windowWidth);
Y = sgolayfilt(y, polynomialOrder, windowWidth);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,A);
% p=new_right_points(X,Y,C);

N=size(X,1);
[m,c]=maxfun2(X);
% for neck
new1=zeros(c,1);
for i=1:c-1
    if(X(i)>C(1,1) && Y(i)<C(1,2))
        new1(i)=i;
    end
end
k1=find(new1);
x1=X(k1(1):k1(end));
y1=Y(k1(1):k1(end));
[p1,l1]=findpeaks(-x1);
p(1,1)=x1(l1);
p(1,2)=y1(l1);

% for sholder
x2=x1(l1(end):end);
y2=y1(l1(end):end);
der2=zeros(size(x2,1)-1,1);
for i=1:size(x2,1)-1
    der2(i)=(y2(i)-y2(i+1))/(x2(i)-x2(i+1));
end
[p2,l2]=findpeaks(-der2);
p(2,1)=x2(l2(1));
p(2,2)=y2(l2(1));

% armpit point

new3=zeros(N-c,1);
for i=c+1:N
    if(X(i)>C(1,1) && Y(i)<C(1,2))
        new3(i)=i;
    end
end
k3=find(new3);
x3=X(k3(1):k3(end));
y3=Y(k3(1):k3(end));
[p3,l3]=findpeaks(-y3);
der3=zeros(size(y3,1)-l3(end)-1,1);
% for i=l3(end):size(y3,1)-1
%      der3(i-l3+1)=(y3(i+1)-y3(i))/(x3(i+1)-x3(i))+1;
% end
% der3=abs(der3);
% [p_3,l_3]=minfun2(der3);
% p(3,1)=x3(l3+l_3);
% p(3,2)=y3(l3+l_3);


% plot(x3(l3),y3(l3),'b*');

% plot(x3,y3,'r*');

% plot(X,Y,'b-');
plot(p(:,1),p(:,2),'b*');