function [h] = getImageFeatures(wordMap, dictionarySize)
    histogram = hist(reshape(wordMap,1,[]), dictionarySize);
%    h = histogram./repmat(sum(histogram),1,size(histogram,2));
    h = histogram/norm(histogram,1);
    h = h';
end
