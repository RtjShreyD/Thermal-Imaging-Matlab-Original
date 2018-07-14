filename1='newvstr1.csv';
A1=initiate2(filename1);
filename2='newvside2.csv';
A2=initiate2(filename2);
A2=flip(A2,2);
[a1,a2]=alignfun(A1,A2); 
imshow(A2);
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
t=70.375/557;
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

a2=flip(a2,2);
[X1,Y1,~,y1]=mysmooth(a2);
[~,minloc]=minfun2(y1);
[~,right]=findpeaks(-X1(minloc:end));
a(1,1)=481-X1(minloc+right(1)-1);
a(1,2)=Y1(minloc+right(1)-1);

a2=flip(a2,2);
[X2,Y2,~,y2]=mysmooth(a2);
[~,minloc2]=minfun2(y2);
[~,maxloc2]=maxfun2(y2);
[~,left]=findpeaks(-X2(minloc2:maxloc2));
p(2,1)=X2(minloc2+left(1)-1);
p(2,2)=Y2(minloc2+left(1)-1);
xr(:)=abs(X2(:)-a(1,1));
yr(:)=abs(Y2(:)-a(1,2));
sr=xr+yr;
sr=sr';
[~,locofmin]=minfun2(sr);
siz=l(1,1)-locofmin+1;
dist=zeros(siz,1);
for i=locofmin:l(1,1)
    dist(i-locofmin+1)=sqrt((X2(i)-p(2,1)).^2+(Y2(i)-p(2,2)).^2);
end
[~,crctloc]=minfun2(dist);
crctloc=crctloc-1+locofmin;
% plot(dist);
% a2=flip(a2,2);
a(1,1)=X2(crctloc);
a(1,2)=Y2(crctloc);
%%
figure
imshow(a2);
hold on
plot(X2,Y2,'b-');
plot(X2(locofmin),Y2(locofmin),'r*');
plot(X2(crctloc),Y2(crctloc),'b*');