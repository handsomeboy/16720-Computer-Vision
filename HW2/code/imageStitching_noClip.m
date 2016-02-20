function [panaImge] = imageStitching_noClip(img1, img2, H2to1)
    fixed_width = 1280;
    [height, width] = size(img2(:,:,1));
    % set corner_points to compute ratio and fixed_height
    corner_points = zeros(4,3);
    corner_points(1,:) = [1,1,1];
    corner_points(2,:) = [width,1,1];
    corner_points(3,:) = [1,height,1];
    corner_points(4,:) = [width, height,1];
    corner_points = corner_points';

    % compute coordinate for warped image
    correspon_points = H2to1*corner_points;
    correspon_points = correspon_points ./ repmat(correspon_points(3,:),3,1);
    correspon_points = correspon_points(1:2,:);

    M = zeros(3,3);
    % find the maximum width that may exceed the fixed_width, try to find the width and ratio is fixed_width diveded by maximum width, so that we can squeeze the image in to a reasonable size. 
    max_width = max(correspon_points(1,2), correspon_points(1,4));
    ratio = fixed_width / max_width;
    M(1,1) = ratio - 0.1;
    M(2,2) = ratio - 0.1;
    M(3,3) = 1;
    % the highest point should have a negative coordinate indicate that this point is not visible, so move down the whole picture so that the whole image is visible.
    M(3,1) = 0;
    max_height = min(correspon_points(2,1), correspon_points(2,2));
    M(3,2) = abs(max_height);

    M = M';
    % get largest height, so every pixel is visible.
    fixed_height = abs(max_height) + max(correspon_points(2,3), correspon_points(2,4));

    outsize = [round(fixed_height), fixed_width];

    im1_warp = warpH(img1, M, outsize);
    im2_warp = warpH(img2, M*H2to1, outsize);

    % set up two mask for two images
    mask1 = zeros(size(img1,1), size(img1,2));
    mask1(1,:) = 1;
    mask1(end,:) = 1;
    mask1(:,1) = 1;
    mask1(:,end) = 1;
    mask1 = bwdist(mask1,'city');
    mask1 = mask1/max(mask1(:));
    mask_warp1 = warpH(mask1, M, outsize);
    
    mask2 = zeros(size(img2,1), size(img2,2));
    mask2(1,:) = 1;
    mask2(end,:) = 1;
    mask2(:,1) = 1;
    mask2(:,end) = 1;
    mask2 = bwdist(mask2,'city');
    mask2 = mask2/max(mask2(:));
    mask_warp2 = warpH(mask2, M*H2to1, outsize);
    

    mask_to1 = mask_warp1./(mask_warp1+mask_warp2);
    mask_to2 = mask_warp2./(mask_warp1+mask_warp2);
    mask_to1(isnan(mask_to1)) = 0;
    mask_to2(isnan(mask_to2)) = 0;
    im3 = repmat(mask_to1,1,1,3).*single(im1_warp) + repmat(mask_to2,1,1,3).*single(im2_warp);
    panaImge = uint8(im3);
    figure;
    image(panaImge);

end
