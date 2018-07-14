function m=I2Loc(Vertices,Nmin)
s=size(Nmin);
m=zeros(s(1,1),2);
for i=1:s(1,1)
    m(i,1)=Vertices(Nmin(i,1),1);
    m(i,2)=Vertices(Nmin(i,1),2);
end
end
