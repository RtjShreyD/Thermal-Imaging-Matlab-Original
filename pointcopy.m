function p=pointcopy(p1,p2)
r=size(p1,1);
p=zeros(r,2,2);
p(:,1,:)=p1(:,:);
p(:,2,:)=p2(:,:);

end