function M = LucasKanadeAffine(It, It1)
    [height, width] = size(It);
    It1 = double(It1);
    It = double(It);
    p = zeros(3,3);
    M = p + diag([1,1,1]);
    [dx,dy] = gradient(It);
    It1 = double(It1);
    dx_vector = dx(:);
    dy_vector = dy(:);
    H = [dx_vector dy_vector]' * [dx_vector dy_vector];

    delta = 1;
    threshold = 0.2;

    while (delta > threshold)
        x = 1:width;
        y = 1:height;
        [X,Y] = meshgrid(x,y);
        X = X(:);
        Y = Y(:);
        ori = [X,Y,ones(size(X,1),1)];
        ori = ori';
        warp = M * ori;
        warp_x = reshape(warp(1,:)',height,width);
        warp_y = reshape(warp(2,:)',height,width);
        warp_img = interp2(It1,warp_x,warp_y,'nearset');
        warp_img(isnan(warp_img)) = 0;
        error_img = It - warp_img;
        error_vector = error_img(:);
        Q1 = [X,X,Y,Y,ones(size(X,1),1),ones(size(X,1),1)];
        Q2 = [dx_vector,dy_vector,dx_vector,dy_vector,dx_vector,dy_vector];
        Q = Q1.*Q2;
        H = Q'*Q;
        delta_p = H\Q' * error_vector;
        delta = norm(delta_p);
        M = M + [reshape(delta_p,2,3);zeros(1,3)];
    end
end
