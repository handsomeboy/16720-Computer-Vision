% reference: http://www.cs.cmu.edu/~16385/lectures/Lecture22.pdf
function [u, v] = LucasKanadeBasis(It, It1, rect, basis)
    % get reference image.
    ref_img = It(rect(2):rect(4), rect(1):rect(3));
    [dx, dy] = gradient(ref_img);
    dx_vector = dx(:);
    dy_vector = dy(:);
    H = [dx_vector dy_vector]' * [dx_vector dy_vector];
    coefficient1 = H \ [dx_vector,dy_vector]';
    delta = 1;
    threshold = 0.01;
    [height,width,level] = size(basis);
    basis_vector = reshape(basis,height*width,level);
    coefficient2 = basis_vector';
    % put all the parameters together.
    coefficient = [coefficient2;coefficient1];
    p = zeros(level+2,1);
    while (delta > threshold) 
        X = rect(1) + p(level+1):rect(3) + p(level+1);
        Y = rect(2) + p(level+2):rect(4) + p(level+2);
        [X,Y] = meshgrid(X,Y);
        warp_img = interp2(It1, X, Y);
        error_img = ref_img - warp_img;
        error_vector = error_img(:);
        delta_p = coefficient*error_vector;
        p(1:level) = p(1:level) + delta_p(1:level);
        p(level+1) = p(level+1) + delta_p(level+1);
        p(level+2) = p(level+2) + delta_p(level+2);
        delta = norm([delta_p(level+1), delta_p(level+2)]);
    end
    u = p(level+1);
    v = p(level+2);
end
