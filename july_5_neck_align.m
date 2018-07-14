filename1='v3f1.csv';
A1=initiate2(filename1);
% A1=flip(A1,2);
filename2='v3s1.csv';
A2=initiate2(filename2);
A2=flip(A2,2);
[a1,a2]=alignfun(A1,A2);
% imshow(a1)

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
[location2,p1]=few_right_points(a1);
[location,p2]=few_left_points(a1);
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

[front,back,pneck]=newsideneck(a2,l);
ps(1,1,1)=pneck(1,1);
ps(1,1,2)=pneck(1,2);
ps(1,2,1)=pneck(2,1);
ps(1,2,2)=pneck(2,2);
P=pointadjust(p1,p2,C);
[a,b,d]=measureneck(P,ps);
neck=d*t;
% error=((a+b)/2)-(14.5/(pi*t));

figure;
imshow(a1);
hold on
plot(X1,Y1,'b-','linewidth',2);
% plot(P(5,:,1),P(5,:,2),'r*');
plot(P(1,:,1),P(1,:,2),'r*');
% plot(P(1,1,1)+error/2,P(1,1,2),'g*');
% plot(P(1,2,1)-error/2,P(1,2,2),'g*');
% plot(X1(location2(:)),Y1(location2(:)),'r*');
% plot(X1(location(3)+20),Y1(location(3)+20),'r*');
% plot(X1(location2(5)),Y1(location2(5)),'g*');
% plot(X1(location(5)),Y1(location(5)),'g*'); +error/2
% plot(C(1,1),C(1,2),'r*');
% plot(X1(l1),Y1(l1),'g*');
% plot(X1(location2(1)),Y1(location2(1)),'r*');
% plot(X1(location(1)),Y1(location(1)),'r*');
% plot(x1(location2(1)),y1(location2(1)),'g*');
% plot(x1(location(1)),y1(location(1)),'g*');


figure;
imshow(a2);
hold on
plot(X2,Y2,'b-','linewidth',2);
plot(C2(1,1),C2(1,2),'r*');
% plot(X2(front),Y2(front),'r*');
% plot(X2(back),Y2(back),'r*');
% plot(x2(front),y2(front),'g*');
% plot(x2(back),y2(back),'g*');
% plot(X2(l(2)),Y2(l(2)),'r*');
% plot(ps(5,:,1),ps(5,:,2),'r*');
% plot(ps(1,1,1)+error/2,ps(1,1,2),'g*');
% plot(ps(1,2,1)-error/2,ps(1,2,2),'g*');
plot(ps(1,:,1),ps(1,:,2),'r*');
