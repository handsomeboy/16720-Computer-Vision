% function: compute filterBank and dictionary.
% @param  imagenames.
% @return filterBank and dictionary.
function [filterBank, dictionary] = getFilterBankAndDictionary(train_imagenames)
% alpha is set randomly.
    % alpha = 100;
    alpha = 150;
% filterBank is created by helper function.
    filterBank = createFilterBank();
    filter_responses = zeros(alpha*length(train_imagenames), 3*size(filterBank,1));
% apply each filter to every image.
    for k = 1:length(train_imagenames)
        img = imread(strcat('../dat/',train_imagenames{k}));
        imgh = size(img,1);
        imgw = size(img,2);     
        p =randperm(imgh*imgw, alpha);
        p = p';
        responses = extractFilterResponses(img, filterBank);
        responses_sample = responses(p,:);
        filter_responses((k-1)*alpha+1:k*alpha,:) = responses_sample;
    end
% K is set randomly.
    % K = 200;
    K = 300;
% creat dictionary using matlab function.
    [~, dictionary] = kmeans(filter_responses, K, 'EmptyAction', 'drop');
% change dictionary into column wise.
    dictionary = dictionary';
end
