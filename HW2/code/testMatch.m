im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');

[compareX,compareY] = makeTestPattern(9,256);

[locs1, desc1] = briefLite(im1,compareX, compareY);
[locs2, desc2] = briefLite(im2,compareX, compareY);

matches = briefMatch(desc1, desc2);
plotMatches(im1, im2, matches, locs1, locs2);
save('matches.mat','matches');
