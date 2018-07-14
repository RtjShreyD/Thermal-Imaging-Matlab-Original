function [d,k]=measurebicep(leftloc,rightloc,X,Y)
[r1,~]=size(X);
[~,c]=maxfun2(X);
distl=zeros(r1,2);
k5=zeros(leftloc(2),1);
for j=leftloc(3):r1
    k5(1:leftloc(2),1)=sqrt((X(j)-X(1:leftloc(2))).^2+(Y(j)-Y(1:leftloc(2))).^2);   
    [distl(j,1),distl(j,2)]=minfun2(k5);
end
m1=maxfun(distl(:,1));
k=zeros(c-rightloc(2)+1,1);
distr=zeros(r1,2);
for j=c:rightloc(3)
%     for i=rightloc(2):c
        k(1:c-rightloc(2)+1)=sqrt((X(j)-X(rightloc(2):c)).^2+(Y(j)-Y(rightloc(2):c)).^2);
        [k2,distr(j,2)]=minfun2(k);
        distr(j,1)=k2;
end
m2=maxfun(distr(:,1));
d=pi*(m1+m2)/2;
end  