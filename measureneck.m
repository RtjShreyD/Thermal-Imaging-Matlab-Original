function [a,b,d]=measureneck(p1,p2)
a=sqrt((p1(1,1,1)-p1(1,2,1)).^2+(p1(1,1,2)-p1(1,2,2)).^2);
b=sqrt((p2(1,1,1)-p2(1,2,1)).^2+(p2(1,1,2)-p2(1,2,2)).^2);
d=pi*(a+b)/2;
end