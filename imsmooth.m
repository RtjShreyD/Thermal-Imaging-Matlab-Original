function im=imsmooth(I,R,C,r,c,in)
[r1,c1]=size(I);
I1=imcrop(I,[R C r c]);
I1=edge(I1);
I1=imdilate(I1,strel('diamond',in));
I1=bwmorph(I1,'thin',inf);
new=zeros(r1,c1);
for i=C:c+C
    for j=R:R+r
        new(i,j)=I1(i-C+1,j-R+1);
    end
end
im=I|new;
 im=edge(im);
%  im=bwmorph(im,'bridge',inf);
im=imfill(im,'holes');
