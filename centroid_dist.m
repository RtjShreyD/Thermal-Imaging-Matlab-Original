filename1='vf1.csv';
A1=initiate2(filename1);
[X1,Y1,x1,y1]=mysmooth(A1);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
C=step(blob,a1);
cro=crotchfn(A1,C,X1,Y1);
z1=zeros(cro-minloc(Y1)+1,1);
for i=minloc(Y1):cro
        z1(i-minloc(Y1)+1)=sqrt((C(1,1)-X1(i)).^2+((C(1,2)-Y1(i)).^2));
end
z2=zeros(size(Y1,1)-cro+1+minloc(Y1),1);
for i=cro:size(Y1,1)
    z2(i-cro+1,1)=sqrt((C(1,1)-X1(i)).^2+((C(1,2)-Y1(i)).^2));
end
for i=1:minloc(Y1)
    z2(size(Y1,1)+1-cro+i,1)=sqrt((C(1,1)-X1(i)).^2+((C(1,2)-Y1(i)).^2));
end
plot(z1);
figure
plot(z2);