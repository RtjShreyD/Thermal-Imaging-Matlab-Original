a=maxfun(data);
b=minfun(data);
threshold=(a+b)/2;
I=thresholding(data,threshold);
imshow(I);