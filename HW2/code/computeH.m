% reference: https://www.cs.ubc.ca/grads/resources/thesis/May09/Dubrofsky_Elan.pdf
% http://www.cse.psu.edu/~rtc12/CSE486/lecture16.pdf
function [H2to1] = computeH(p1,p2)
    N = size(p1,2);
    x1 = p1(1,:)';
    x2 = p2(1,:)';
    y1 = p1(2,:)';
    y2 = p2(2,:)';
    empty = zeros(N,3);
    % set up matrix A, 
    A = [-x2 -y2 -ones(N,1) -empty x1.*x2 x1.*y2 x1;
        -empty -x2 -y2 -ones(N,1) y1.*x2 y1.*y2 y1];
    % give up using svd, using eigenvalue instead
    % [H,~,~] = svd(A'*A);
    [V,D] = eig(A'*A);
    [~,index] = min(sum(D));
    H = V(:,index);
    H2to1 = vec2mat(H,3);
end
