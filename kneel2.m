function [p1,p2]=kneel2(a)
[X,Y,x,y]=mysmooth(a);
blob=vision.BlobAnalysis;
blob.AreaOutputPort = false;
blob.BoundingBoxOutputPort = false;
a=logical(a);
c=step(blob,a);
[peaks,locs]=findpeaks(Y);
for j=1:size(peaks,1)
    for i=1:size(peaks,1)-1
        if peaks(i+1)-peaks(i)<10
            peaks(i+1)=peaks(i);
        end
    end
end
maxp=maxfn(peaks);
maxloc1=maxloc(peaks);
mxloc=locs(maxloc1);
for i=1:size(peaks,1)
    if peaks(i)==maxp
        peaks(i)=0;
    end
end
max2loc=maxloc(peaks);
max2p=locs(max2loc);
a=min(max2p,mxloc);
b=max(max2p,mxloc);
dist=zeros(b-a+1,1);
for i=1:b-a+1
    dist(i,1)=distcent(i+a-1,c,X,Y);
end
min_loc=minloc(dist);
mindis=min_loc+a-1;
R=mindis;
x_n=zeros(R-a+1,1);
y_n=zeros(R-a+1,1);
for i=1:R-a+1
    x_n(i)=x(i+a-1);
end
for i=1:R-a+1
    y_n(i)=y(i+a-1);
end
xmal=maxloc(x_n);
xmil=minloc(x_n);
% figure
% plot(dist);
% figure
% plot(x_n,-y_n,'r-');
% hold on
% plot(x_n(xmal),-y_n(xmal),'g*');
% plot(x_n(xmil),-y_n(xmil),'g*');
angle=atan((y_n(xmil)-y_n(xmal))/(size(x_n,1)));
q=transpose(x_n);
w=transpose(-y_n);
v = [q;w];
x_center=0;
y_center=0;
center = repmat([x_center; y_center], 1, length(q));
theta = -angle;       
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
s = v - center; 
so = R*s;       
vo = so + center;   
% x_n_rotated = vo(1,:);
y_n_rotated = vo(2,:);
for i=1:3
y_n_rotated=sgolayfilt(y_n_rotated,3,45);
end
[~,loc_y_n_r]=findpeaks(y_n_rotated);
knee=loc_y_n_r+a-1;
% figure
% plot(x_n_rotated, y_n_rotated, 'r-');
% axis equal
% hold on 
% plot(x_n_rotated(loc_y_n_r),y_n_rotated(loc_y_n_r),'g*');
% figure
% imshow(A);
% hold on
% plot(c(1,1),c(1,2),'r*');
% plot(X,Y,'b-','linewidth',2);
% plot(X(a),Y(a),'b*');
% plot(X(b),Y(b),'r*');
% plot(X(mindis),Y(mindis),'g*');
% plot(X(knee),Y(knee),'g*');
B=Y;
xmx=maxloc(X);
kn33=zeros(size(X));
a1=max(mxloc,knee);
b1=min(mxloc,knee);
for i=1:size(X,1)
if i<=a1 && i>=b1
    kn33(i)=X(i);
end
end
[~,kn33l]=findpeaks(kn33);
% figure 
% plot(kn33);
% hold on
% plot(kn33l(end,1),kn33(kn33l(end,1)),'r*');
ymp=kn33l(end);
knl=Y(ymp)-Y(xmx)+Y(knee);
for i=1:size(Y,1)
    if abs(B(i)-knl)<=0.8 && X(i)<X(knee)
        B(i)=i;
    else
        B(i)=0;
    end
end
M=find(B);
disk=zeros(size(M));
for i=1:size(M,1)
    disk(i)=((Y(ymp)-Y(M(i)))^2+(X(ymp)-X(M(i)))^2)^(0.5);
end
% p1=M(minloc(disk));

for i=1:size(M,1)-1
    if M(i+1)-M(i)<2
        M(i)=0;
    end
end
as=find(M);
p1=M(as(1,1));
p2=M(as(2,1));
% p2=M(minloc(disk));
% figure
%  imshow(A);
% hold on
% plot(c(1,1),c(1,2),'r*');
% plot(X,Y,'b-','linewidth',2);
% plot(X(p1),Y(p1),'g*');
% plot(X(p2),Y(p2),'g*');
% % plot(X(M),Y(M),'r*');
% plot(X(knee),Y(knee),'r*');
% plot(X(xmx),Y(xmx),'g*');
% plot(X(ymp),Y(ymp),'g*');
end
