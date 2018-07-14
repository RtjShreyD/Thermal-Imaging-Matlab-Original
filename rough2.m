clear
clc
kk=7;
filename1='madeshf1.csv';
filename2='madeshs1.csv';
filename3='vf2.csv';
filename4='vs2.csv';
A1=initiate2(filename1,kk);
A2=initiate2(filename2,kk);
A2=flip(A2,2);
[a1,a2]=alignfun(A1,A2);
A3=initiate2(filename3,kk);
[a3,a4]=alignfun(A3,flip(A2,2));
% for knee we have to take a side view picture from side view .
a5=initiate2(filename4,kk);
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
% 
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
t=70.375/(maxfun(Y2)-minfun(Y2));

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
[~,~,pneck]=newsideneck(a2,l);
ps(1,1,1)=pneck(1,1);
ps(1,1,2)=pneck(1,2);
ps(1,2,1)=pneck(2,1);
ps(1,2,2)=pneck(2,2);

% measuring
t1=measurethigh(P,ps);
ValuesInInches(10)=t1*t;
ValuesInInches(7)=realmeasureneck(filename1,filename2);
t3=measureinseam(X1,Y1,x1,y1,cro);
ValuesInInches(12)=t3*t;
t4=measurehip(P,ps);
ValuesInInches(3)=t4*t;
t5=measurechest(P,ps);
ValuesInInches(1)=t5*t;
t6= measurenbicep(leftloc,rightloc,X1,Y1);
ValuesInInches(6)=t6*t;
t7=measuretrouserwaist(P,ps);
ValuesInInches(9)=t7*t;
t8=measureshirtwaist(P,ps);
ValuesInInches(2)=t8*t;
t9=measureoutseam(X1,Y1,cro,P);
ValuesInInches(11)=t9*t;
%
t9=measuresleeve(a3);
ValuesInInches(5)=t9*t;
[t10,~]=measureslenght(a3,a4);
ValuesInInches(4)=t*t10;
t11=measureshoulder(a3);
ValuesInInches(8)=t11*t;
ValuesInInches(13)=measureknee(a5);
ValuesInInches=ValuesInInches';


%% 
figure;
imshow(a1);
hold on
plot(X1,Y1,'b-','linewidth',2);
% plot(X1(location2(2)),Y1(location2(2)),'r*');
% plot(X1(location(2)),Y1(location(2)),'r*');
plot(P(:,:,1),P(:,:,2),'r*');
plot(C(1,1),C(1,2),'r*');
% plot(X1(l1),Y1(l1),'g*');
figure;
imshow(a2);
hold on
plot(X2,Y2,'b-','linewidth',2);
plot(C2(1,1),C2(1,2),'r*');
plot(ps(1,:,1),ps(1,:,2),'r*');

