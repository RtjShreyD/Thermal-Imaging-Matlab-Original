function p=sideneck(A2)
A2=flip(A2,2);
[X,Y,~,y]=mysmooth(A2);
[~,minloc]=minfun2(y);
[~,right]=findpeaks(-X(minloc:end));
p(1,1)=480-X(minloc+right(1)-1);
p(1,2)=Y(minloc+right(1)-1);

A2=flip(A2,2);
[X2,Y2,~,y2]=mysmooth(A2);
[~,minloc2]=minfun2(y2);
[~,maxloc2]=maxfun2(y2);
[~,left]=findpeaks(-X2(minloc2:maxloc2));
p(2,1)=X2(minloc2+left(1)-1);
p(2,2)=Y2(minloc2+left(1)-1);
end