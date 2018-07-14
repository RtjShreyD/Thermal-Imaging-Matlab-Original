filename1='newvstr1.csv';
A1=initiate2(filename1);
filename2='newvside2.csv';
A2=initiate2(filename2);
A2=flip(A2,2);
[a1,a2]=alignfun(A1,A2); 
% imshow(A2);
%% 

[X1,Y1,x1,y1]=mysmooth(a1);
[X2,Y2,x2,y2]=mysmooth(a2);
% blob analysis
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
C2=step(blob,a2);
% [X2,Y2,x2,y2]=mysmooth(a2);
%% 
cro=crotchfn(A1,C,X1,Y1);
hip =hipfn(C2,X2,Y2);
hiplevel=y2(hip);
[location2,p1]=new_right_points(X1,Y1,x1,y1,C,cro,hiplevel);
[location,p2]=new_left_points(X1,Y1,x1,y1,C,cro,hiplevel);
leftloc=location;
rightloc=location2;
X=X1;
Y=Y1;
% pixel to physical ratio
t=70.375/(maxfun(y2)-minfun(y2));
%% 
% plotting
P=pointadjust(p1,p2,C);
hip=hipfn(C,X2,Y2);
p_1=P(:,1,2);
Pround=round(p_1);
l=zeros(2,size(Pround,1));
%% 
for i=1:size(Pround,1)
    p=find(abs(y2-Pround(i))<0.01);
    l(1,i)=p(1);
    l(2,i)=p(end);
end
%% 
ps=loc2(X2,Y2,l);
%% 

% adujust side neck
pneck=newsideneck(a2,l);
ps(1,1,1)=pneck(1,1);
ps(1,1,2)=pneck(1,2);
ps(1,2,1)=pneck(2,1);
ps(1,2,2)=pneck(2,2);
%% 
% measuring
t1=measurethigh(P,ps);
msthigh=t1*t;
t2=measureneck(P,ps);
msneck=t2*t;
t3=measureinseam(Y1,P);
msinseam=t3*t;
t4=measurehip(P,ps);
mshipp=t4*t;
t5=measurechest(P,ps);
mschest=t5*t;
t6= measurebicep(leftloc,rightloc,X1,Y1);
msbicep=t6*t;

%% plotinng
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
plot(C2(1,1),C2(1,2),'r*');
plot(ps(:,:,1),ps(:,:,2),'r*');

% % figure
% % imshow(a2);
% % figure
% imshow(a1);