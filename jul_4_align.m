filename1='4f1.csv';
A1=initiate2(filename1);
% A1=flip(A1,2);
filename2='4s1.csv';
A2=initiate2(filename2);
A2=flip(A2,2);
[a1,a2]=alignfun(A1,A2);
% imshow(a2)
%%
[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
C2=step(blob,a2);

cro=crotchfn(a1,C,X1,Y1);
hip =hipfn(C2,X2,Y2);
hiplevel=y2(hip);
[location2,p1]=new_right_points(a1,cro,hiplevel);
[location,p2]=new_left_points(a1,cro,hiplevel);
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
P=pointcopy(p1,p2);
info(6,1)=((maxfun(Y1)-minfun(Y1)));
info(6,2)=(maxfun(y1)-hiplevel);
info(6,3)=(maxfun(y1)-345);
info(:,2)=info(:,1)-info(:,2);
info(:,3)=info(:,1)-info(:,3);
info(:,4)=-info(:,3)+info(:,2);
%%
% figure;
% imshow(a1);
% hold on
% plot(X1,Y1,'b-','linewidth',2);
% plot(P(:,:,1),P(:,:,2),'r*');

% plot(X1(location2(:)),Y1(location2(:)),'r*');
% plot(X1(location(3)+20),Y1(location(3)+20),'r*');
% plot(X1(location2(5)),Y1(location2(5)),'g*');
% plot(X1(location(5)),Y1(location(5)),'g*');
% plot(C(1,1),C(1,2),'r*');
% plot(X1(l1),Y1(l1),'g*');
figure;
imshow(a2);
hold on
plot(X2,Y2,'b-','linewidth',2);
plot(C2(1,1),C2(1,2),'r*');
plot(ps(:,:,1),ps(:,:,2),'r*');