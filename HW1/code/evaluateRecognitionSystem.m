% load images'names
load('../dat/traintest.mat');
num = length(test_imagenames);
% right is a vector to record whether we predict correctly.
% right(1,i) means that the i'th image is predicted correctly.
right = zeros(1,num);
label = zeros(1,num);
for i = 1:num;
% function guessImage is modified in order to debug.
% check returned features so that we will know whether we did extract features from
% test images.
name = guessImage(strcat('../dat/',test_imagenames{i}));
    for k = 1:8
        if (strcmp(name, mapping{1,k}))
            label(1,i) = k;
        end
    end
% record if we predict correctly
    if label(1,i) == test_labels(1,i);
        right(1,i) = 1;
    end
end
% number that we correctly predict.
right_num = sum(right);
accuracy = right_num/160;
confusion_mat = confusionmat(label, test_labels);
