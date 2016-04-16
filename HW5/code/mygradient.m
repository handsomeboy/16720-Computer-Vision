function [mag,ori] = mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%
if size(I,3) == 3
    I = rgb2gray(I);
end
[mag,ori] = imgradient(I);
end
