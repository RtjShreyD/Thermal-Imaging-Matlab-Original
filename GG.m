%data to gray
function im= GG(I)
[r,c]=size(I);
im=zeros(r,c);
for i=1:r
    for j=1:c
            im(i,j)=int8(I(i,j));
    end
end
end