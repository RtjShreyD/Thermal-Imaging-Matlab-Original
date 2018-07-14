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
imshow(A);

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

% armpit point finder
N=size(smoothX,1);
N_2=round(N/2);
new_1=zeros(N_2,1);
for i=N_2:N
    if(smoothX(i)<centroid(1,1) && smoothY(i)<centroid(1,2))
        new_1(i-N_2-1,1)=i;
    end
end
k=find(new_1);
x_1=smoothX(new_1(k(1)):new_1(k(end)));
y_1=smoothY(new_1(k(1)):new_1(k(end)));
n_1=size(x_1,1);
der_1=zeros(n_1-1,1);
for j=1:size(der_1,1)
    der_1(j)=((y_1(j)-y_1(j+1))/(x_1(j)-x_1(j+1)))-1;
end
der_1=abs(der_1);
[m,c]=minfun2(der_1);
point_1(1,1)=x_1(c);
point_1(1,2)=y_1(c);

%  upper sholder point
new_2=zeros(N_2,1);
for i=1:N_2

    if(smoothX(i)<centroid(1,1) && smoothY(i)<centroid(1,2))
        new_2(i)=i;
    end
end
k_2=find(new_2);
x_2=smoothX(new_2(k_2(1)):new_2(k_2(end)));
y_2=smoothY(new_2(k_2(1)):new_2(k_2(end)));
n_2=size(x_2,1);
der_2=zeros(n_2-1,1);
for j=1:size(der_2,1)
    der_2(j)=((y_2(j)-y_2(j+1))/(x_2(j)-x_2(j+1)));
end
der_2=abs(der_2);
[m_2,c_2]=minfun2(der_2);
point_2(1,1)=x_2(c_2);
point_2(1,2)=y_2(c_2);

%  neck point
new_3=zeros(N_2,1);
for i=c_2:N_2

    if(smoothX(i)<centroid(1,1) && smoothY(i)<centroid(1,2))
        new_3(i)=i;
    end
end
k_3=find(new_3);
x_3=smoothX(new_3(k_3(1)):new_3(k_3(end)));
y_3=smoothY(new_3(k_3(1)):new_3(k_3(end)));
n_3=size(x_3,1);
der_3=zeros(n_3-1,1);
for j=1:size(der_3,1)
    der_3(j)=(x_3(j)-x_3(j+1))/(y_3(j)-y_3(j+1));
end
der_3=abs(der_3);
[m_3,c_3]=minfun2(der_3);
point_3(1,1)=x_3(c_3);
point_3(1,2)=y_3(c_3);
% for thumb bone point
% im going to take the centroid of the gand portion
% to approximate it
n_4=round(N/20);
dist=zeros(n_4,1);
for i=1:n_4
    dist(i)=sqrt((smoothX(i)-smoothX(N-i-1)).^2+(smoothY(i)-smoothY(N-i-1)).^2);
end
hold off
% plot(dist);