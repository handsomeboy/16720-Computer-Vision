%% reference for this method:
% http://blog.csdn.net/jwh_bupt/article/details/9625469
% function: getImageFeaturesSPM.
% param: layerNum, wordMap, dictionarySize.
% return: h(features for all train images);
%% implementation
function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
    L = layerNum - 1;
    imgh = size(wordMap,1);
    imgw = size(wordMap,2);
% before spilt the image, determine whether a image's size can be devided by 2^L
% if not, padding the margins with zeros.
% note: if we need pad odd numbers of lines(i.e. 3 lines). we pad 1 line on left,
% 2 lines on right.
    if mod(imgh,2^L) ~= 0
%         delta = 2^L - (mod(imgh,2^L));
        delta = mod(imgh,2^L);
        wordMap = wordMap(fix(delta/2)+1:imgh-round(delta/2),:);
%         wordMap = [zeros(fix(delta/2),imgw);wordMap;zeros(round(delta/2),imgw)];
    end
    imgh = size(wordMap,1);
    if mod(imgw,2^L) ~= 0
%         delta = 2^L - (mod(imgw,2^L));
        delta = mod(imgw,2^L);
        wordMap = wordMap(:,fix(delta/2)+1:imgw-round(delta/2));
%         wordMap = [zeros(imgh,fix(delta/2)) wordMap zeros(imgh,round(delta/2))];
    end
    imgw = size(wordMap,2);
% after padding, compute height and width for a sub_matrix for the finest layer.
    sub_h = imgh/(2^L);
    sub_w = imgw/(2^L);
    h = [];
% compute the finnest layer
% take the matrix into smallest sub matrics.
    hist_cell = mat2cell(wordMap,sub_h.*ones(1,2^L),sub_w.*ones(1,2^L));
    num = length(hist_cell).^2;
    h_finest = cell(1,num);
    for i = 1:num
        sub_mat = hist_cell{i};
        sub_hist = getImageFeatures(sub_mat, dictionarySize);
        sub_hist = sub_hist';
        h_finest{i} = sub_hist;
    end
    h = cell2mat(h_finest).*0.5;
 
    h_finest = reshape(h_finest, 2^L, 2^L);
% after compute the finest layer, using the output to form rest layers.
    for z = L-1:-1:1
% using mat2cell and cell2mat to reshape gather 4 sub_matrices into 1 large matrix(which is a component for next layer).
        h_finest = mat2cell(cell2mat(h_finest),2.*ones(1,2^z),2.*dictionarySize*ones(1,2^z));
% compute histogram by summing 4 sub_matrices up.
        for y = 1:1:2^z*2^z
            sub_mat = h_finest{y};
            sub_mat = reshape(sum(sub_mat),[],2);
            sub_mat = sub_mat';
            sub_mat = sum(sub_mat);
%             sub_mat = sub_mat/norm(sub_mat,1);
            h_finest{y} = sub_mat;
        end
        sub_layer = cell2mat(reshape(h_finest,1,[]));
% apply weight and add to h
        h = [h sub_layer.*(2^(z-L-1))];
    end
% this is to compute layer0 since it has the same weight to layer1.
    final_mat = cell2mat(h_finest);
    final_mat = reshape(sum(final_mat),[],2);
    final_mat = final_mat';
    final_mat = sum(final_mat);
%     final_mat = final_mat/norm(final_mat,1);
    h = [h final_mat.*(2^(-L))];
% traspose h and L1 normalization.
    h = h'/norm(h,1);
end
