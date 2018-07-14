data=csvread('front.csv',1,1,[1 1 320 240]);
dataset=(data-minfun(data))/(maxfun(data)-minfun(data));
level=graythresh(dataset);
t2=3*average(dataset)-2*median(dataset);
t=level;
% imshow(dataset);
A=dataset>t2;
% figure;
A=imfill(A,'holes');
% imshow(A);
bound=bwboundaries(A,4);
B=bound{1,1};
% n=10;
% sz=size(B);
% s=sz(1,1)/n;
% s=round(s);
% diff=sz(1,1)-n*s;
% new=zeros(200,2);
% new(:,:)=B(301:500,:);
new=B;
x=new(:,2);
y=new(:,1);

windowWidth = 45;
polynomialOrder = 3;
smoothX = sgolayfilt(x, polynomialOrder, windowWidth);
smoothY = sgolayfilt(y, polynomialOrder, windowWidth);
imshow(A, []);
hold on;
plot(smoothX, smoothY, 'b-','linewidth',2);
x1=smoothX(946:1029);
y1=smoothY(946:1029);
der1=zeros(82,1);
for i=1:83
    der1(i)=((y1(i)-y1(i+1))/(x1(i)-x1(i+1)))-1;
end;
der1=abs(der1);
[m,c]=minfun2(der1);
point(1,1)=x1(c);
point(1,2)=y1(c);
plot(point(:,1),point(:,2),'r*');
k=find(abs(smoothX-91)<0.1);
reqpnt=B(k(1,1),:);
plot(reqpnt(:,2),reqpnt(:,1),'r*');