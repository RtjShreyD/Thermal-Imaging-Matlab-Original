function y=geometricmean(I)
[r,c]=size(I);
mul=1;
n=r*c;
for i=1:r
    for j=1:c
        mul=mul*nthroot(I(i,j),n);
    end
end
y=mul;
end