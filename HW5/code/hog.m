function ohist = hog(I)
%
% compute orientation histograms over 8x8 blocks of pixels
% orientations are binned into 9 possible bins
%
% I : grayscale image of dimension HxW
% ohist : orinetation histograms for each block. ohist is of dimension (H/8)x(W/8)x9
% TODO

% normalize the histogram so that sum over orientation bins is 1 for each block
%   NOTE: Don't divide by 0! If there are no edges in a block (ie. this counts sums to 0 for the block) then just leave all the values 0. 
% TODO

[mag, ori] = mygradient(I);
threshold = 0.1*max(mag(:));
ori = abs(ori);
mag = im2col(mag, [8,8], 'distinct');
ori = im2col(ori, [8,8], 'distinct');
[height, width] = size(mag);
row = height / 8;
column = width / 8;

ori(mag < threshold) = 0;
ori(ori > 160) = -9;
ori(ori > 140) = -8;
ori(ori > 120) = -7;
ori(ori > 100) = -6;
ori(ori > 80) = -5;
ori(ori > 60) = -4;
ori(ori > 40) = -3;
ori(ori > 20) = -2;
ori(ori > 0) = -1;
ori = abs(ori);
histo = hist(ori);
histo = histo(2:end,:)
scale = sum(histo);
scale(scale == 0) = 1;
norm_histo = histo./repmat(scale, 9, 1);
norm_histo = norm_histo';
ohist = reshape(norm_histo, [row, column, 9]);

end
