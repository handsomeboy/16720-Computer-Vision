function [panoImg] = imageStitching(im1, im2, H2to1)
    outSize = [size(im1, 1), 1700];
    warp2 = warpH(im2, H2to1, outSize);
    panoImg = warp2;
    [height,width] = size(im1(:,:,1));
    panoImg(1:height, 1:width, :) = im1;
end
