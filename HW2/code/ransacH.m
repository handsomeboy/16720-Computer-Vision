% reference: http://6.869.csail.mit.edu/fa12/lectures/lecture13ransac/lecture13ransac.pdf
function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
    bestH = zeros(3,3);
    N = size(matches, 1);
    locs2_temp = locs2';
    locs2_temp = locs2_temp(1:2,:);
    locs2_temp = locs2_temp(:,matches(:,2));
    locs2_temp = [locs2_temp; ones(1,size(locs2_temp,2))];
    locs1_ref = locs1';
    locs1_ref = locs1_ref(:,matches(:,1));
    best_num = 0;

    for i = 1:nIter
        p = randperm(N,4);
        locs1_new = locs1(:,1:2);
        locs2_new = locs2(:,1:2);
        p1 = (locs1_new(p,:))';
        p2 = (locs2_new(p,:))';
        h2to1_temp = computeH(p1,p2);
        locs1_temp = h2to1_temp*locs2_temp;
        locs1_temp = locs1_temp./ locs1_temp(3,:);
        dif = locs1_ref - locs1_temp;
        dif = dif(1:2,:);
        distance = arrayfun(@(iter) norm(dif(:,iter)), 1:size(dif,2));
        distance(distance >= tol) = 0;
        distance(distance < tol) = 1;
        inlier_num = sum(distance);
        if inlier_num > best_num
            bestH = h2to1_temp;
        end
    end
end
