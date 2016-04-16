
function [x,y,score] = detect(I,template,ndet)
%
% return top ndet detections found by applying template to the given image.
%   x,y should contain the coordinates of the detections in the image
%   score should contain the scores of the detections
%

    feature = hog(I);
    [height, width, ~] = size(feature);
    for i = 1:9
        scores(:,:,i) = imfilter(feature(:,:,i), template(:,:,i));
    end
    sc = sum(scores, 3);
    scoreLine = sc(:);
    indecies = 1:length(scoreLine);
    resultMap = [scoreLine,indecies'];
    sort_Map = sortrows(resultMap, [-1,2]);
    output = [];
    output = [output;sort_Map(1,:)];
    for i = 2:length(indecies)
        count = 0;
        temp = sort_Map(i,:);
        [tempy, tempx] = ind2sub([height,width], temp(2));
        for j = 1:size(output,1)
            com = output(j,:);
            [comy, comx] = ind2sub([height,width], com(2));
            diff = [comy - tempy, comx - tempx];
            dis = diff*diff';
            if sqrt(dis) > 8*sqrt(2)
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
    detected = output(1:ndet,:);
    % detected = sort_Map(1:ndet,:);
    [y,x] = ind2sub([height, width], detected(:,2));
    x = 8*x - 4;
    y = 8*y - 4;
    score = detected(:,1);
end
