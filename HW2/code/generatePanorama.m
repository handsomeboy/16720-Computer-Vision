function [im3] = generatePanorama(im1, im2)
    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);
    [matches] = briefMatch(desc1, desc2, 0.5);
    [bestH] = ransacH(matches, locs1, locs2, 1000, 0.5);
    [panaImge] = imageStitching_noClip(im1, im2, bestH);
    im3 = panaImge;
end
