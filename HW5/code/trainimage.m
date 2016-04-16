load template_images_pos.mat
figure
for i = 1:5
    temp = template_images_pos{i};
    subplot(2,3,i);
    imshow(temp);
end