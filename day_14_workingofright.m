% extraction of csv data to matlab
data=csvread('front.csv',1,1,[1 1 320 240]);

% converting it to an intensity gray scal image
data=(data-minfun(data))/(maxfun(data)-minfun(data));

% thresholding level
T=3*average(data)-2*median(data);

% thresholding
A=data>T;

% filling unwanted holes
A=imfill(A,'holes');
% imshow(A);

% finding the boundaries
bound=bwboundaries(A);
B=bound{1,1};
new=B;
x=new(:,2);
y=new(:,1);

% smoothening the boundaries using SG filter
windowWidth = 25;
polynomialOrder = 3;
smoothX = sgolayfilt(x, polynomialOrder, windowWidth);
smoothY = sgolayfilt(y, polynomialOrder, windowWidth);

% blob analysis for centroid
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
centroid=step(blob,A);
C=centroid;
X=smoothX;
Y=smoothY;
[m,c]=maxfun2(X);
N=size(X,1);
% for arm pit point
new_1=zeros(N,1);
for i=c:N
    if (X(i)>C(1,1) && Y(i) < C(1,2))
        new_1(i)=i;        
    end
end
k_1=find(new_1);
x_1=X(new_1(k_1(1)):new_1(k_1(end)));
y_1=Y(new_1(k_1(1)):new_1(k_1(end)));
n_1=size(x_1,1);
der_1=zeros(n_1-1,1);
for j=1:size(der_1,1)
    der_1(j)=((y_1(j)-y_1(j+1))/(x_1(j)-x_1(j+1)))+1;
end
der_1=abs(der_1);
[n,c1]=minfun2(der_1);
der_1(c1)=1;
[m1,c2]=minfun2(der_1);
if (x_1(c2) > x_1(c1))
    c2=c1;
end
point(1,1)=x_1(c2);
point(1,2)=y_1(c2);

% To find the shoulder point
new_2=zeros(N,1);
for i=1:c
        if (X(i)>C(1,1) && Y(i) < C(1,2))
        new_2(i)=i;        
        end
end
k_2=find(new_2);
x_2=X(new_2(k_2(1)):new_2(k_2(end)));
y_2=Y(new_2(k_2(1)):new_2(k_2(end)));
n_2=size(x_2,1);
der_2=zeros(n_2-1,1);
for j=1:size(der_2,1)
    der_2(j)=((y_2(j)-y_2(j+1))/(x_2(j)-x_2(j+1)));
end
der_2=abs(der_2);
[m_2,c_2]=minfun2(der_2);
point(2,1)=x_2(c_2);
point(2,2)=y_2(c_2);

%  neck point
% can use x_2 from c_2
dx_dy=zeros(c_2-1,1);
for i=1:c_2-1
    dx_dy(i)=(x_2(i)-x_2(i+1))/(y_2(i)-y_2(i+1));
end
dx_dy=abs(dx_dy);
[m_3,c1_3]=minfun2(dx_dy);
point(3,1)=x_2(c1_3);
point(3,2)=y_2(c1_3);
imshow(A);
hold on;
plot(smoothX,smoothY,'b-');
plot(point(:,1),point(:,2),'r*');
