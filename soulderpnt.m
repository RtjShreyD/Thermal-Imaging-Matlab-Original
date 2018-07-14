A1=initiate2('5f2.csv');
A2=initiate2('5s1.csv');
[a1,a2]=alignfun(A1,A2);
%%
[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a1=logical(a1);
c=step(blob,a1);
%% 
[p,l]=findshoulder(a1);
d1=measureshoulder(a1);
[d2,locofthumb]=measuresleeve(a1);
[d3,~]=measureslenght(a1,a2);
t=70.375/(maxfun(Y1)-minfun(Y1));
%%
msshldr=t*d1;
mssleeve=t*d2;
mslength=t*d3;
%% plotting 
figure
imshow(a1);
hold on
plot(X1,Y1,'b-','linewidth',2);
% plot(c(1,1),c(1,2),'r*');
plot(p(1,1),p(1,2),'r*');
plot(p(2,1),p(2,2),'g*');

% plot(X(locofthumb),Y(locofthumb),'r*');
% plot((size(a1,2)+1)-X1(rh),Y1(rh),'r*');