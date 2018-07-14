figure
mean2=average(data);
med2=median(data);
mode2=3*(med2)-2*(m2);
gg1=thresholding(data,mode2);
imshow(gg1);
