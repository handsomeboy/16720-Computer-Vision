load(fullfile('..','data','aerialseq.mat'));
[height, width, level] = size(frames);
rects = cell(level,1);
rects{1} = diag([1,1,1]);
for i = 1:level - 1
    img = double(frames(:,:,i));
    img_next = double(frames(:,:,i+1));
    mask = SubtractDominantMotion(img, img_next);
    % record M 
%     rects{i+1} = M;
    img_final = imfuse(img,mask,'blend');
    imshow(uint8(img_final));
    pause(0.02);
end
save(fullfile('..','results','aerialseqrects.mat'),'rects');
