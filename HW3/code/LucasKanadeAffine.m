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
    x = 1:width;
    y = 1:height;
    [X,Y] = meshgrid(x,y);
    X = X(:);
    Y = Y(:);
    Q = [X.*dx_vector, X.*dy_vector,Y.*dx_vector,Y.*dy_vector,dx_vector,dy_vector];
    H = Q'*Q;
    para = H \ Q';
    count = 1;
    delta = 1;
    threshold = 0.01;

    while (delta > threshold)
        count = count + 1;
        ori = [X,Y,ones(size(X,1),1)];
        ori = ori';
        warp = M * ori;
        warp_x = reshape(warp(1,:)',height,width);
        warp_y = reshape(warp(2,:)',height,width);
        warp_img = interp2(It1,warp_x,warp_y,'nearset');
        warp_img(isnan(warp_img)) = 0;
        error_img = It - warp_img;
        error_vector = error_img(:);
        delta_p = para * error_vector;
        delta = norm(delta_p);
        M = M + [reshape(delta_p,2,3);zeros(1,3)];
        if (count == 50)
            break;
        end
    end
end
