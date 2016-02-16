%% reference: http://www.mathworks.com/help/matlab/ref/bsxfun.html
% there are two ways to compute distance, both are listed below, one of them
% is commented.
function [histInter] = distanceToSet(wordHist, histogram)
%% method that implement bsxfun
%     histInter = sum(bsxfun(@min, wordHist, histogram));
%% method that doesn't implement bsxfun, but using repmat to compute
    T = size(histogram,2);
    wordHist_rep = repmat(wordHist,1,T);
    histInter = sum(min(wordHist_rep, histogram));
end
