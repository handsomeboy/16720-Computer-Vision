function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup
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
[~,~,V] = svd(E);
F1 = vec2mat(V(:,9),3);
F2 = vec2mat(V(:,8),3);

syms lambda;
eqn = det(lambda * F1 + F2 - lambda*F2) == 0;
solu = solve(eqn, lambda);
solu = real(double(solu));
F = cell(1,3);
if (size(solu,1) == 1)
    F{1} = solu * F1 + (1 - solu) * F2;
    F{1} = T'*F{1}*T;
end

if (size(solu,1) == 3)
    for i = 1:3
        F{i} = solu(i) * F1 + (1 - solu(i)) * F2;
        F{i} = T'*F{i}*T;
    end
end

end

