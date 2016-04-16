function det_res = multiscale_detect(image, template, ndet)
% input:
%     image - test image.
%     template - [16 x 16x 9] matrix.
%     ndet - the number of return values.
% output:
%      det_res - [ndet x 3] matrix
%                column one is the x coordinate
%                column two is the y coordinate
%                column three is the scale, i.e. 1, 0.7 or 0.49 ..
    if size(image,3) == 3
        image = rgb2gray(image);
    end
    final = [];
    temp_image = image;
    scale = 1;
    while min(size(temp_image)) > 128
        [x, y, score] = detect(temp_image, template, ndet);
        temp_final(:,1) = x / scale;
        temp_final(:,2) = y / scale;
        temp_final(:,3) = scale;
        temp_final(:,4) = score;
        scale = scale * 0.7;
        final = [final;temp_final];
        temp_image = imresize(image, scale);
    end
    final = sortrows(final, -4);
    output = [];
    output = [output;final(1,:)];
    for i = 2:size(final,1)
        count = 0;
        temp = final(i,:);
        [tempy, tempx] = ind2sub(size(image), temp(2));
        for j = 1:size(output,1)
            com = output(j,:);
            [comy, comx] = ind2sub(size(image), com(2));
            diff = [comy - tempy, comx - tempx];
            dis = diff*diff';
            if dis > 128*sqrt(2)
                count = count + 1;
            end
        end
        if count == size(output,1)
            output = [output; temp];
        end
        if ndet == size(output,1)
            break;
        end
    end
    det_res = output(1:ndet,1:3);

end
