function mask = SubtractDominantMotion(image1, image2)
    double_img1 = double(image1);
    double_img2 = double(image2);
    M = LucasKanadeAffine(image1, image2);
    [height,width] = size(image2);
    x = 1:width;
    y = 1:height;
    [X,Y] = meshgrid(x,y);
    X = X(:);
    X = X';
    Y = Y(:);
    Y = Y';
    in = [X;Y;ones(1,size(X,2))];
    out = M*in;
    out_x = out(1,:);
    out_y = out(2,:);
    out_x = reshape(out_x,height,width);
    out_y = reshape(out_y,height,width);
    warp_img = interp2(double_img2,out_x,out_y);
    warp_img(isnan(warp_img)) = 0;
    deltaI = double_img1 - warp_img;
    deltaI(deltaI > 100) = 0;
    deltaI(deltaI < 20) = 0;
    [row,col] = find(deltaI > 20);
    BW = bwselect(deltaI,col,row,4);
    BW = bwareaopen(BW,10);
    SE = strel('disk',6,4);
    BW = imdilate(BW,SE);
    SE = strel('disk',4,4);
    BW = imerode(BW,SE);
    mask = BW;
end
