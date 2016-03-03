
load(fullfile('..','data','carseq.mat')); % variable name = frames. 

rect = [60, 117, 146, 152];
corner_points = zeros(2,4);
[height, width, frame_num] = size(frames);
rects = zeros(frame_num,4);
rects(1,:) = rect;

for i = 1:frame_num - 1
    corner_points(:,1) = [rect(1);rect(2)];
    corner_points(:,2) = [rect(1);rect(4)];
    corner_points(:,3) = [rect(3);rect(4)];
    corner_points(:,4) = [rect(3);rect(2)];
    img = double(frames(:,:,i));
    imshow(frames(:,:,i));
    hold on;
    line(corner_points(1,1:2),corner_points(2,1:2), 'Color','g','LineWidth',1);
    line(corner_points(1,2:3),corner_points(2,2:3), 'Color','g','LineWidth',1);
    line(corner_points(1,3:4),corner_points(2,3:4), 'Color','g','LineWidth',1);
    line([corner_points(1,4);corner_points(1,1)],[corner_points(2,4);corner_points(2,1)], 'Color','g','LineWidth',1);
    hold off;
    pause(0.02);
    img_next = double(frames(:,:,i+1));
    [u,v] = LucasKanade(img, img_next, rect);
    rect = [rect(1)+u rect(2)+v rect(3)+u rect(4)+v];
    rect = round(rect);
    rects(i+1,:) = rect;
end
% save the rects
save(fullfile('..','results','carseqrects.mat'),'rects');
