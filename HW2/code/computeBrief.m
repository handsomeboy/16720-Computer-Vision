% function computeBrief
% input im, GaussianPyramid, locsDoG, k,levels of GaussianPyramid, test pair.
% output locs and desc: properties of matched points.
function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY)
    % set small patch, and change index to subscript so that we can access every points in patch
    x_max = size(im,2);
    y_max = size(im,1);
    patchWidth = 9;
    small_patch = [patchWidth,patchWidth];
    [xx,xy] = ind2sub(small_patch, compareX);
    [yx,yy] = ind2sub(small_patch, compareY);
    half_patchWidth = round(patchWidth/2);
    % set mean to 0
    xx = xx - half_patchWidth;
    xy = xy - half_patchWidth;
    yy = yy - half_patchWidth;
    yx = yx - half_patchWidth;
    % drop points that near edge. 
    locs = locsDoG(locsDoG(:,1) > 4,:);
    locs = locs(locs(:,2) > 4,:);
    locs = locs(locs(:,1) <= (x_max - 4),:);
    locs = locs(locs(:,2) <= (y_max - 4),:);
    desc = zeros(size(locs,1), size(compareX,1));

    for line = 1:size(locs,1)
        x = locs(line,1);
        y = locs(line,2);
        l = locs(line,3);
        X = repmat(x,size(compareX,1),1);
        Y = repmat(y,size(compareX,1),1);
        % X1, X2, Y1, Y2 corresponding to points in small_patch.
        X1 = X+xx;
        Y1 = Y+xy;
        X2 = X+yx;
        Y2 = Y+yy;
        L1 = repmat(l,size(compareX,1),1) + 2;
        L2 = L1;
        % get points for GaussianPyramid.
        G1 = GaussianPyramid(sub2ind(size(GaussianPyramid),Y1,X1,L1));
        G2 = GaussianPyramid(sub2ind(size(GaussianPyramid),Y2,X2,L2));
        % decide whether should be 0 or 1.
        Output = (G1 - G2)';
        Output(Output > 0) = 1;
        Output(Output <= 0) = 0;
        desc(line,:) = Output;
    end
end
