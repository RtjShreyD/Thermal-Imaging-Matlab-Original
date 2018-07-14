function knee=measureknee(a)
[p1,p2]=kneel2(a);
[X,Y,x,y]=mysmooth(a);
knee=(70.375/(maxfun(y)-minfun(y)))*(abs(x(p1)-x(p2)))*pi;
end