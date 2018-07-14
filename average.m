%data to gray
function im= average(I)
[r,c]=size(I);
sum=0;
n=r*c;
for i=1:r
    for j=1:c
        sum=sum+I(i,j);
    end
end
im=sum/n;
end
