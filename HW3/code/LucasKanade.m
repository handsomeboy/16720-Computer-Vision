%reference: http://www.cs.cmu.edu/~16385/lectures/Lecture23.pdf
function [u,v] = LucasKanade(It, It1, rect)
    % get reference image in the first image
    ref_img = It(rect(2):rect(4), rect(1):rect(3));
    % use inverse compositional algorithm to speed up computation
    [dx, dy] = gradient(ref_img);
    dx_vector = dx(:);
    dy_vector = dy(:);
    H = [dx_vector dy_vector]' * [dx_vector dy_vector];
    % set parameter
    delta = 1;
    threshold = 0.1;
    p = [0,0];
    while (delta > threshold)
        X = rect(1)+p(1):rect(3) + p(1);
        Y = rect(2)+p(2):rect(4) + p(2);
        [X,Y] = meshgrid(X,Y);
        % warp the next image
        warp_img = interp2(It1, X, Y);
        error_img = ref_img - warp_img;
        error_vector = error_img(:);
        % vecterize elements so that we can perfrom a matrix multipy 
        Z = [dx_vector.*error_vector, dy_vector.*error_vector];
        steep_descent = (sum(Z))';
        delta_p = H\steep_descent;
        delta = norm(delta_p);
        p(1) = p(1) + delta_p(1);
        p(2) = p(2) + delta_p(2);
    end
    u = p(1);
    v = p(2);
end 
    
