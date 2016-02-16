function [PrincipalCurvature] = computePrincipalCurvature(DoGPyramid)
    n = size(DoGPyramid,3);
    r = size(DoGPyramid,1);
    c = size(DoGPyramid,2);
    for i = 1:n
        [dx,dy] = gradient(DoGPyramid(:,:,i));
        [dxx,dxy] = gradient(dx);
        [dyx,dyy] = gradient(dy);
        R = (dxx+dyy).^2 ./ (dxx.*dyy - dxy.*dyx);
        % for j = 1:r*c
        %     h = [dxx(j) dxy(j);dyx(j) dyy(j)];
        %     e = eig(h);
        %     R(j) = (e(1)+e(2))^2 / (e(1)*e(2));
        % end
        % R = reshape(R,r,c);
        PrincipalCurvature(:,:,i) = R;
    end
end
