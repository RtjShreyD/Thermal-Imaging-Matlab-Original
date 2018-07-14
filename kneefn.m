function [knl]= kneefn(c,x,y,X,Y)
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
B=Y;
knl=Y(mxloc)-Y(max2p)+Y(knee);
end