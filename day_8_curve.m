data=csvread('front.csv',1,1,[1 1 320 240]);
dataset=(data-minfun(data))/(maxfun(data)-minfun(data));
level=graythresh(dataset);
t2=3*average(dataset)-2*median(dataset);
t=level*(maxfun(data)-minfun(data));
A=dataset>t2;
A=imfill(A,'holes');
bound=bwboundaries(A);
Vertices=bound{1,1};
k=LineCurvature2D(Vertices);
maxi=maxfun(k);
mini=minfun(k);
blob=vision.BlobAnalysis;
blob.AreaOutputPort=false;
blob.BoundingBoxOutputPort=false;
c=step(blob,A);
imshow(A);

% Nmax=find(k>maxi-0.1);
% using index to function function 
% maxB=I2Loc(Vertices,Nmax);
% hold on
% plot(maxB(:,2),maxB(:,1),'r*');
% for maximum
% Nmin=find(k==mini);
% using index to function function 
% minB=I2Loc(Vertices,Nmin);
% hold on
% plot(minB(:,2),minB(:,1),'b*');