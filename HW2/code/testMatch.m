im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');
% im1 = imread('../data/model_chickenbroth.jpg');
% im2 = imread('../data/chickenbroth_03.jpg');
% im1 = imread('../data/pf_scan_scaled.jpg');
% im2 = imread('../data/pf_desk.jpg');
% im2 = imread('../data/pf_floor_rot.jpg');
% im2 = imread('../data/pf_floor.jpg');
% im2 = imread('../data/pf_pile.jpg');

if ismatrix(im1)
    im1 = repmat(im1,1,1,3);
end
if ismatrix(im2)
    im2 = repmat(im2,1,1,3);
end

% [compareX,compareY] = makeTestPattern(9,256);

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

matches = briefMatch(desc1, desc2);
plotMatches(im1, im2, matches, locs1, locs2);
