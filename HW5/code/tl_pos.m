function template = tl_pos(template_images_pos)
% input:
%     template_images_pos - a cell array, each one contains [16 x 16 x 9] matrix
% output:
%     template - [16 x 16 x 9] matrix

    template = zeros(16,16,9);
    for i = 1:length(template_images_pos)
        sample = template_images_pos{i};
        template = template + hog(sample);
    end
    template = template / length(template_images_pos);
end
