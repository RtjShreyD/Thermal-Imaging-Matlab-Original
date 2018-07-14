data=csvread('front2.csv',1,1,[1 1 320 240]);
dataset=(data-minfun(data))/(maxfun(data)-minfun(data));
level=graythresh(dataset);
t2=3*average(dataset)-2*median(dataset);
t=level;
% imshow(dataset);
A=dataset>t;
% figure;
A=imfill(A,'holes');
% imshow(A);
bound=bwboundaries(A);
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
polynomialOrder = 2;
smoothX = sgolayfilt(x, polynomialOrder, windowWidth);
smoothY = sgolayfilt(y, polynomialOrder, windowWidth);
imshow(A, []);
hold on;
plot(smoothX, smoothY, 'r-','linewidth',2);
hold off;
x1=smoothX(822:905);
y1=smoothY(822:905);
% p=polyfit(x1,y1,6);
der2=zeros(83,1);
% for i=1:83
%    der2(i)=6*x1(i)*p(1) + 2*p(2);
% end
% [m,k]=maxfun2(der2);
% y2=zeros(84,1);
% y2(:)=p(1)*(x1(:).^3)+p(2)*(x1(:).^2)+p(3)*x1(:)+p(4);
% diff=y2-y1;
% y2=polyval(p,x1);
% figure
% plot(x1,y1,'o')
% hold on
% plot(x1,y2)
% hold off
% der1=zeros(83,1);
% for i=1:83
%     der1(i)=((y1(i)-y1(i+1))/(x1(i)-x1(i+1)))-1;
% end;
% der1=abs(der1);
% [m,c]=minfun2(der1);
% point(1,1)=B(822+c,1);
% point(1,2)=B(822+c,2);
% imshow(A);
% hyprb = @(b,x1) b(1) + b(2)./(x1 + b(3));                 % Generalised Hyperbola
% NRCF = @(b) norm(y1 - hyprb(b,x1));                       % Residual Norm Cost Function
% B0 = [1; 1; 1];
% B1 = fminsearch(NRCF, B0);                               % Estimate Parameters
% figure(1)
% plot(x1, y1, 'pg')
% hold on
% plot(x1, hyprb(B1,x1), '-r');
% hold off
% grid
%  text(0.7, 0.52, sprintf('y = %.4f %+.4f/(x %+.4f)', B1))
