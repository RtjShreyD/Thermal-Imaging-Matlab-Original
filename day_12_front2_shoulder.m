data=csvread('front2.csv',1,1,[1 1 320 240]);
dataset=(data-minfun(data))/(maxfun(data)-minfun(data));
level=graythresh(dataset);
t2=3*average(dataset)-2*median(dataset);
t=level;
% imshow(dataset);
A=dataset>t2;
% figure;
A=imfill(A,'holes');
% imshow(A);
bound=bwboundaries(A);
B=bound{1,1};
new=B;
x=new(:,2);
y=new(:,1);

windowWidth = 45;
polynomialOrder = 9;
smoothX = sgolayfilt(x, polynomialOrder, windowWidth);
smoothY = sgolayfilt(y, polynomialOrder, windowWidth);
imshow(A, []);
hold on;
plot(smoothX, smoothY, 'r-','linewidth',2);
x1=smoothX(873:957);
y1=smoothY(873:957);
der1=zeros(83,1);
for i=1:83
    der1(i)=((y1(i)-y1(i+1))/(x1(i)-x1(i+1)))-1;
end;
der1=abs(der1);
[m,c]=minfun2(der1);
point(1,1)=x1(c);
point(1,2)=y1(c);
plot(point(:,1),point(:,2),'b*');
k=find(abs(smoothX-86)<0.1);
reqpnt=B(k(1,1),:);
plot(reqpnt(:,2),reqpnt(:,1),'b*');
plot(x1,y1,'b-');