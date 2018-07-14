filename1='5f2.csv';
a1=initiate2(filename1);

filename2='5s1.csv';
a2=initiate2(filename2);
[A1,A2]=alignfun(a1,a2);
% imshow(A2);
% A2=flip(A2,2);
%%
[X1,Y1,x1,y1]=mysmooth(A1);
[X2,Y2,x2,y2]=mysmooth(A2);
t=70.375/(maxfun(Y2)-minfun(Y2));
[d2,p]=measureslenght(A1,A2);
mslen2=t*d2;

%% 
imshow(A1);
hold on
plot(X1,Y1,'b-','linewidth',2);

% plot(X1(location),Y1(location),'r*');
% plot(X1(locofthumb),Y1(locofthumb),'r*');

figure
imshow(A2);
hold on
plot(X2,Y2,'b-','linewidth',2);
% plot(c1(1,1),c1(1,2),'r*');
% plot(p(1,1),p(1,2),'r*');
% plot(p(2,1),p(2,2),'g*');
% plot(X2(foundindex),Y2(foundindex),'r*');
% plot((size(a1,2)+1)-X1(rh),Y1(rh),'r*');