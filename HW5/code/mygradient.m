function [mag,ori] = mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%

image = rgb2gray(I);
[mag,ori] = imgradient(image);
end
