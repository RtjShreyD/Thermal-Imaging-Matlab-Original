mean=average(data2);
gm=geometricmean(data2);
hm=harmonicmean(data2);
med=median(data2);
mode1=3*(mean)-2*(med);
gg=thresholding(data2,mode1);
imshow(gg);
