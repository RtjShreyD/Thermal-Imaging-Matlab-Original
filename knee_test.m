A=initiate2('s1.csv');
[X,Y,x,y]=mysmooth(A);
% p=sidekneefun(A);
loc=minloc(X);
imshow(A);
hold on
% plot(X,Y,'b-','linewidth',2);
plot(X(loc),Y(loc),'g*');
plot(X(maxloc(X)),Y(maxloc(X)),'g*');
% plot(p(1,1),p(1,2),'r*');
% plot(p(2,1),p(2,2),'r*');