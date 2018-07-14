
mean=average(data);
med=median(data);
mode=3*(med)-2*(mean);
gg1=thresholding(data,mode);
imshow(gg1);
title('mode');
figure;
imshow(thresholding(data,mean));
title('mean');
figure;
imshow(thresholding(data,med));
title('median');