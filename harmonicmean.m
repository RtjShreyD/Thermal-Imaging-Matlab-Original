function y=harmonicmean(I)
[r,c]=size(I);
sum=0;
n=r*c;
for i=1:r
    for j=1:c
        sum=sum+(1/I(i,j));
    end
end
y=n/sum;
end