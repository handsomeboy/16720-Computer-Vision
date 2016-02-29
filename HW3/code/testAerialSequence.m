load(fullfile('..','data','aerialseq.mat'));
[height, width, level] = size(frames);
for i = 1:level - 1
    img = double(frames(:,:,i));
    % imshow(frames(:,:,i));
    % hold on;
    img_next = double(frames(:,:,i+1));
    mask = SubtractDominantMotion(img, img_next);
    img_final = imfuse(img,mask,'blend');
    imshow(uint8(img_final));
    pause(0.02);
end
save(fullfile('..','results','aerialseqrects.mat','rects'));
