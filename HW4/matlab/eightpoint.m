function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

% load('../data/some_corresp.mat')
% I1 = imread('../data/im1.png')
% I2 = imread('../data/im2.png')

% imwidth = M(1);
% imheight = M(2);
T = zeros(3,3);
T(1,1) = 1/M;
T(2,2) = 1/M;
T(3,3) = 1;

pt1 = [pts1,ones(size(pts1,1),1)];
pt1 = T*pt1';
pt1 = repmat(pt1',1,3);
pt2 = [pts2,ones(size(pts2,1),1)];
pt2 = T*pt2';
pt2 = pt2';
pt2 = [repmat(pt2(:,1),1,3),repmat(pt2(:,2),1,3),repmat(pt2(:,3),1,3)];

A = pt1.*pt2;
E = A'*A;
[V,D] = eig(E);
[~,index] = min(sum(D));
H = V(:,index);
M = vec2mat(H,3);
[FU,FS,FV] = svd(M);
FS(3,3) = 0;
F_refine = FU*FS*FV';
% F_refine = refineF(M,pts1,pts2);
F = T'*F_refine*T;
end

