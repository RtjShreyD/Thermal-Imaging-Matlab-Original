% what my idea in this program is to shift it a bit below andmake it
% symmetric wrt the centroid of blob usig blob analysis.

filename1='v3f1.csv';
A1=initiate2(filename1);
% side normal
filename2='v3s1.csv';
A2=initiate2(filename2);
% A1=flip(A1,2);
A2=flip(A2,2);
[a1,a2]=alignfun(A1,A2);
A3=initiate2('v3f2.csv');
% figure
% imshow(A1);
% figure
% imshow(a2);
[a3,a4]=alignfun(A3,flip(A2,2));

[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
[X3,Y3,x3,y3]=mysmooth(a3);
[X4,Y4,x4,y4]=mysmooth(a4);
% blob analysis
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
C2=step(blob,a2);
% [X2,Y2,x2,y2]=mysmooth(a2);
%% 
cro=crotchfn(a1,C,X1,Y1);
hip =hipfn(C2,X2,Y2);
hiplevel=y2(hip);
[location2,p1]=new_right_points(a1,cro,hiplevel);
[location1,p2]=new_left_points(a1,cro,hiplevel);
leftloc=location;
rightloc=location2;
X=X1;
Y=Y1;
% pixel to physical ratio
t=70.375/(maxfun(Y1)-minfun(Y1));

% plotting
P=pointadjust(p1,p2,C);
p_1=P(:,1,2);
Pround=round(p_1);
l=zeros(2,size(Pround,1));

for i=1:size(Pround,1)
    p=find(abs(y2-Pround(i))<0.01);
    l(1,i)=p(1);
    l(2,i)=p(end);
end
ps=loc2(X2,Y2,l);
pneck=newsideneck(a2,l);
ps(1,1,1)=pneck(1,1);
ps(1,1,2)=pneck(1,2);
ps(1,2,1)=pneck(2,1);
ps(1,2,2)=pneck(2,2);
x1(location1(:))=P(:,1,1);
y1(location1(:))=P(:,1,2);
x1(location2(:))=P(:,2,1);
y1(location2(:))=P(:,2,2);
windowWidth = 71;
polynomialOrder = 3;
% smooth them using sowitscky golay filter
X5 = sgolayfilt(x1, polynomialOrder, windowWidth);,
Y5 = sgolayfilt(y1, polynomialOrder, windowWidth);
% imshow(a1);
hold on
plot(X5,Y5,'b-','linewidth',2);
plot(X1,Y1,'r-');
plot(P(:,:,1),P(:,:,2),'r*');
