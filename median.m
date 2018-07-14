function y=median(I)
[r,c]=size(I);
n=r*c;
arr=zeros(1,n);
for i=1:r
    for j=1:c
        arr(1,(i-1)*c+j)=I(i,j);
    end
end
arr=sort(arr);
y=arr(1,(n/2));
end