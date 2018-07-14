function [X,Y,x,y]=mysmooth(A)
% take boundaries
bound=bwboundaries(A);
B=bound{1,1};
new=B;
% seperate X and Y
x=new(:,2);
y=new(:,1);
windowWidth = 51;
polynomialOrder = 3;
% smooth them using sowitscky golay filter
X = sgolayfilt(x, polynomialOrder, windowWidth);
Y = sgolayfilt(y, polynomialOrder, windowWidth);
end