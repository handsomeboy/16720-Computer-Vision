function template = tl_lda(template_images_pos, template_images_neg, lambda)
% input:
%     template_images_pos - a cell array, each one contains [16 x 16 x 9] matrix
%     template_images_neg - a cell array, each one contains [16 x 16 x 9] matrix
%     lambda - parameter for lda
% output:
%     template - [16 x 16 x 9] matrix 

    diagnal = diag(lambda*ones(16,1));
    multiDiagnal = zeros(16,16,9);
    for i = 1:9
        multiDiagnal(:,:,i) = diagnal;
    end

    mean_neg = zeros(16,16,9);
    number = length(template_images_neg);
    for i = 1:number
        sample = template_images_neg{i};
        mean_neg = mean_neg + hog(sample);
    end
    mean_neg = mean_neg / number;

    set_mat = zeros(16,16,9);
    for i = 1:number
        sample = template_images_neg{i};
        sample = hog(sample);
        for j = 1:9
            diff = sample(:,:,j)-mean_neg(:,:,j);
            set_mat(:,:,j) = set_mat(:,:,j) + diff*diff';
        end
    end
    set_mat = set_mat / number;
    set_mat = set_mat + multiDiagnal;

    mean_pos = tl_pos(template_images_pos);
    mean_diff = mean_pos - mean_neg;

    template = zeros(16,16,9);
    for i = 1:9
        template(:,:,i) = set_mat(:,:,i) \ mean_diff(:,:,i);
    end

end
