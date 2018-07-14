function point = do_points_left(smoothX,smoothY,centroid)
% armpit point finder
N=size(smoothX,1);
N_2=round(N/2);
new_1=zeros(N_2,1);
for i=N_2:N
    if(smoothX(i)<centroid(1,1) && smoothY(i)<centroid(1,2))
        new_1(i-N_2-1,1)=i;
    end
end
k=find(new_1);
x_1=smoothX(new_1(k(1)):new_1(k(end)));
y_1=smoothY(new_1(k(1)):new_1(k(end)));
n_1=size(x_1,1);
der_1=zeros(n_1-1,1);
for j=1:size(der_1,1)
    der_1(j)=((y_1(j)-y_1(j+1))/(x_1(j)-x_1(j+1)))-1;
end
der_1=abs(der_1);
[m,c]=minfun2(der_1);
point(1,1)=x_1(c);
point(1,2)=y_1(c);

%  upper sholder point
new_2=zeros(N_2,1);
for i=1:N_2

    if(smoothX(i)<centroid(1,1) && smoothY(i)<centroid(1,2))
        new_2(i)=i;
    end
end
k_2=find(new_2);
x_2=smoothX(new_2(k_2(1)):new_2(k_2(end)));
y_2=smoothY(new_2(k_2(1)):new_2(k_2(end)));
n_2=size(x_2,1);
der_2=zeros(n_2-1,1);
for j=1:size(der_2,1)
    der_2(j)=((y_2(j)-y_2(j+1))/(x_2(j)-x_2(j+1)));
end
der_2=abs(der_2);
[m_2,c_2]=minfun2(der_2);
point(2,1)=x_2(c_2);
point(2,2)=y_2(c_2);

%  neck point
new_3=zeros(N_2,1);
for i=c_2:N_2

    if(smoothX(i)<centroid(1,1) && smoothY(i)<centroid(1,2))
        new_3(i)=i;
    end
end
k_3=find(new_3);
x_3=smoothX(new_3(k_3(1)):new_3(k_3(end)));
y_3=smoothY(new_3(k_3(1)):new_3(k_3(end)));
n_3=size(x_3,1);
der_3=zeros(n_3-1,1);
for j=1:size(der_3,1)
    der_3(j)=(x_3(j)-x_3(j+1))/(y_3(j)-y_3(j+1));
end
der_3=abs(der_3);
[m_3,c_3]=minfun2(der_3);
point(3,1)=x_3(c_3);
point(3,2)=y_3(c_3);

end