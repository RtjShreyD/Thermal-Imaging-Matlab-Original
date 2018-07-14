filename1='46.csv';
A1=initiate(filename1);
filename2='46_s.csv';
A2=initiate(filename2);
[a1,a2]=alignfun(A1,A2);
[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);

% blob analysis
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
[X2,Y2,x2,y2]=mysmooth(a2);
cro=crotchfn(A1,C,X1,Y1);
hip =hipfn(C,X2,Y2);
hiplevel=y2(hip);
[location2,p1]=new_right_points(X1,Y1,x1,y1,C,cro,hiplevel);
[location,p2]=new_left_points(X1,Y1,x1,y1,C,cro,hiplevel);
leftloc=location;
rightloc=location2;
X=X1;
Y=Y1;
d=measurebicep(leftloc,rightloc,X,Y);

P=pointadjust(p1,p2,C);
hip=hipfn(C,X2,Y2);
p_1=P(:,1,2);
Pround=round(p_1);
l=zeros(2,size(Pround,1));
for i=1:size(Pround,1)
    l(1:2,i)=find(abs(y2-Pround(i))<0.01);
end
ps=loc2(X2,Y2,l);
d=measureneck(ps,P);
figure;
imshow(a1);
hold on
plot(X1,Y1,'b-','linewidth',2);
plot(X1(location2(:)),Y1(location2(:)),'r*');
plot(X1(location(:)),Y1(location(:)),'r*');
plot(C(1,1),C(1,2),'r*');
% plot(X1(l1),Y1(l1),'g*');
figure;
imshow(a2);
hold on
plot(X2,Y2,'b-','linewidth',2);
% plot(C(1,1),C(1,2),'r*');
plot(ps(:,:,1),ps(:,:,2),'r*');
