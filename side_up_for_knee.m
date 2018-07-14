filename1='5S2.csv';
A1=initiate2(filename1);
% imshow(a1);
A2=initiate2('5f1.csv');
[a1,a2]=alignfun(A1,A2);
imshow(a2);
figure
imshow(a1);
%%
[X1,Y1,x1,y1]=mysmooth(a1);
% blob analysis
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
c1=step(blob,a1);
[X2,Y2,x2,y2]=mysmooth(a2);
% blob analysis
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
c2=step(blob,a2);
% allignment with the front view

%%
[p1,p2]=kneel2(a1);
% knee level 
knl=Y1(p2);

%% 
imshow(a1);
hold on
plot(x1,y1,'b-','linewidth',2);
figure
imshow(a2);
hold on
plot(x2,y2,'b-','linewidth',2);

% plot(X1(p1),Y1(p1),'r*');
% plot(p2(1,1),p2(1,2),'r*');
% plot(X1(p2),Y1(p2),'r*');