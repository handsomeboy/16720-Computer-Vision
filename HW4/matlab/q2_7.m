load('../data/some_corresp.mat');
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
M = max(size(I1));
F = eightpoint(pts1,pts2,M);
load('../data/templeCoords.mat');
number = size(x1,1);
x2 = [];
y2 = [];
for i = 1:number
    sample_x1 = x1(i);
    sample_y1 = y1(i);
    [sample_x2,sample_y2] = epipolarCorrespondence(I1,I2,F,sample_x1,sample_y1);
    x2(i) = sample_x2;
    y2(i) = sample_y2;
end
load('../data/intrinsics.mat');
load('M2.mat');
M1 = diag([1,1,1]);
M1 = K1*[M1,zeros(3,1)];
M2 = K2*M2;
[P,error] = triangulate(M1,[x1,y1],M2,[x2',y2']);
scatter3(P(:,1), P(:,2), P(:,3),'filed');
