%function: getVisualWords.
%param: image I, filterBank, dictionary.
%return: wordMap for that image I.
% implementation
function [wordMap] = getVisualWords(I, filterBank, dictionary)
%     wordMap = zeros(size(I,1),size(I,2));
    responses = extractFilterResponses(I, filterBank);
    dictionary = dictionary';
%     K = 200;
%     map = zeros(size(I,1)*size(I,2),1);
%     for i = 1:(size(I,1)*size(I,2))
%         pixel_response = responses(i,:);
%         dist = pdist2(pixel_response, dictionary);
%         [~,index] = min(dist);
%         map(i,1) = index;
%     end
%     [~,map] = min(pdist2(responses, dictionary),[],2);
    [~, map] = min(pdist2(dictionary, responses));
    wordMap = reshape(map, size(I,1), size(I,2));
end
