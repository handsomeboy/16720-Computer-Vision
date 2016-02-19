
im1 = imread('../data/model_chickenbroth.jpg');
if ismatrix(im1)
    im1 = repmat(im1,1,1,3);
end
A = [];
for i = 0:9
    im2 = imrotate(im1,20*i);
    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);

    matches = briefMatch(desc1, desc2);
    plotMatches(im1, im2, matches, locs1, locs2);
    A = [A;size(matches,1)];
end
