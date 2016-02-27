
load(fullfile('..','data','carseq.mat')); % variable name = frames. 

rects = [60, 117, 146, 152];
corner_points = zeros(2,4);
[height, width, frame_num] = size(frames);

for i = 1:frame_num - 1
    corner_points(:,1) = [rects(1);rects(2)];
    corner_points(:,2) = [rects(1);rects(4)];
    corner_points(:,3) = [rects(3);rects(4)];
    corner_points(:,4) = [rects(3);rects(2)];
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
    [u,v] = LucasKanade(img, img_next, rects);
    rects = [rects(1)+u rects(2)+v rects(3)+u rects(4)+v];
    rects = round(rects);
end
% save the rects
save(fullfile('..','results','carseqrects.mat'),'rects');
