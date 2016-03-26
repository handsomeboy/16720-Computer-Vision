% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       4. Save the correct M2, p1, p2, R and P to q2_5.mat
I1 = imread('../data/im1.png');
load('../data/some_corresp.mat');
load('../data/intrinsics.mat')
[height, width, ~]= size(I1);

M = max(height, width);
F = eightpoint(pts1, pts2, M);
E = essentialMatrix(F,K1,K2);
M2s = camera2(E);
M1s = diag([1,1,1]);
M1s = [M1s,zeros(3,1)];
sample_M1 = K1*M1s;
M2 = [];
for i = 1:4
    sample_M2 = M2s(:,:,i);
    sample_M2 = K2*sample_M2;
    [P,error] = triangulate(sample_M1, pts1, sample_M2, pts2);
    if all(P(:,3) > 0)
        [P1,error1] = triangulate(sample_M2, pts2, sample_M1, pts1);
        if all(P1(:,3) > 0)
            M2(:,:,i) = M2s(:,:,i);
        end
    end
end