function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%%   warp_im : result of warping im by A
% find out output size.
height = out_size(1);
width = out_size(2);
[X, Y] = meshgrid(1:width, 1:height);
X = X(:);
Y = Y(:);
l = length(X);
% establish warped image matrix
Pwarp = [X Y ones(l,1)]';
% comput original matrix
Psou = A\Pwarp;
Psou = round(Psou');
M = Psou(:,1);
N = Psou(:,2);
% find out points which points are out of range. set coordinate (1,1) and set im(1,1) = 0;
P = find(M>width);
Q = find(N>height);
R = find(M<1);
S = find(N<1);
M(P) = 1;
M(Q) = 1;
N(P) = 1;
N(Q) = 1;
M(R) = 1;
M(S) = 1;
N(R) = 1;
N(S) = 1;
temp = im(1,1);
im(1,1) = 0;
% get original points.
index = sub2ind(size(im),N,M);
output = im(index);
% restore the original pixel at (1,1);
im(1,1) = temp;
% reshape warped image.
warp_im = reshape(output,200,150);
end