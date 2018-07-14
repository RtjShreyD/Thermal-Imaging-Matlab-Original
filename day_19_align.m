filename1='46.csv';
A1=initiate(filename1);
[X1,Y1,x1,y1]=mysmooth(A1);
filename2='46_s.csv';
A2=initiate(filename2);
[X2,Y2,x2,y2]=mysmooth(A2);
[m1,c1]=minfun2(y1);
[m2,c2]=minfun2(y2);
[m3,c3]=maxfun2(y1);
[m4,c4]=maxfun2(y2);
full=zeros(320,480);
full(:,1:240)=A1;
i=m1-m2;
% if i is +ve then second image must be shifted above and vice versa
full(m1:end,241:480)=A2(m2:end-i,:);
full=logical(full);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,A1);
A2=full(:,241:480);
[X2,Y2,x2,y2]=mysmooth(A2);
p1=new_right_points(X1,Y1,C);
p2=new_left_points(X1,Y1,C);
P=pointadjust(p1,p2,C);
p_1(:,:)=P(:,1,:);
Pround=round(p_1);

l=zeros(2,size(p_1,1));
for i=1:size(p_1,1)
    l(1:2,i)=find(abs(y2-Pround(i,2))<0.01);
end
ps=loc2(X2,Y2,l);
d=measureneck(ps,P);
figure;
imshow(A1);
hold on
plot(X1,Y1,'b-','linewidth',2);
plot(P(3,2,1),P(3,2,2),'r*');
 plot(C(1,1),C(1,2),'r*');
figure;
imshow(A2);
hold on
plot(X2,Y2,'b-','linewidth',2);
% plot(C(1,1),C(1,2),'r*');
plot(ps(3,2,1),ps(3,2,2),'r*');
