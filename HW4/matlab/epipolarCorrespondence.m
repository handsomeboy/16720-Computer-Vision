function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup
pt1 = [x1;y1;1];
epipolarline = F*pt1;
scale = norm(epipolarline(1:2));
epipolarline = epipolarline/scale;

height = size(im1,1);
windows = 15;
im1_expand = padarray(im1,[windows,windows],'replicate');
im1_window = im1_expand(y1:y1+2*windows,x1:x1+2*windows);
im2_expand = padarray(im2,[windows,windows],'replicate');
min_diff = 0;
index = [0,0];
for i = 1:height
    im2_col = (-epipolarline(2)*i - epipolarline(3)) / epipolarline(1);
    im2_col = round(im2_col);
    im2_window = im2_expand(i:i+2*windows,im2_col:im2_col+2*windows);
    im_diff = double(im2_window) - double(im1_window);
    im_diff_gau = imgaussfilt(im_diff,2);
    differ = sum(abs(im_diff_gau(:)));
    if (differ < min_diff || min_diff == 0)
        min_diff = differ;
        index = [im2_col,i];
    end
end

x2 = index(1);
y2 = index(2);

end
