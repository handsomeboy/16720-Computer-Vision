%% function briefLite
% input: im: image
% Output: locs and desc. properties of matched points
function [locs, desc] = briefLite(im)
    % I set two path in case testPattern.mat has to be put in result directory
    load('testPattern.mat');
    % load('../resutl/testPattern.mat');
    % set some constant
    sigma0 = 1;
    k = sqrt(2);
    levels = [-1 0 1 2 3 4];
    th_contrast = 0.03;
    th_r = 12;
%     patchWidth = 9;
%     nbits = 256;
    [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);
%     [compareX, compareY] = makeTestPattern(patchWidth, nbits);
    [locs, desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY);
end
