filename2='nikside.csv';
A2=initiate2(filename2);
A2=flip(A2,2);[a1,a2]=alignfun(A1,A2);
[X2,Y2,x2,y2]=mysmooth(a2);
% hip=hipfn(C,X2,Y2);


% imshow(a2);