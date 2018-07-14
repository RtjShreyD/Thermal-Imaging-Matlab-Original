
[r,c]=size(data);
d2=thresholding(data,average(data));
figure
imshow(d2);
d3=thresholding(data,86.1);
figure
imshow(d3);
