 function [filterResponses] = extractFilterResponses(I, filterBank)
% CV Fall 2015 - Provided Code
% Extract the filter responses given the image and filter bank
% Pleae make sure the output format is unchanged. 
% Inputs: 
%   I:                  a 3-channel RGB image with width W and height H 
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses

%% determine whether is a RGB image, if not rapmat it;
if ismatrix(I) == 1;
    I = repmat(I,1,1,3);
end 

%% Convert input Image to Lab
doubleI = double(I);
[L,a,b] = RGB2Lab(doubleI(:,:,1), doubleI(:,:,2), doubleI(:,:,3));
pixelCount = size(doubleI,1)*size(doubleI,2);
%filterResponses:    a W*H x N*3 matrix of filter responses
filterResponses = zeros(pixelCount, length(filterBank)*3);


%for each filter and channel, apply the filter, and vectorize

% === fill in your implementation here  ===
%% check size of filter bank and apply every filter to image.
N = size(filterBank,1);
for i = 1:N
    fit = filterBank{i};
    R(:,1) = reshape(imfilter((L),fit,'replicate','same'),[],1);
%     R(:,1) = R(:,1)/norm(R(:,1),1);
    R(:,2) = reshape(imfilter((a),fit,'replicate','same'),[],1);
%     R(:,2) = R(:,2)/norm(R(:,2),1);
    R(:,3) = reshape(imfilter((b),fit,'replicate','same'),[],1);
%     R(:,3) = R(:,3)/norm(R(:,3),1);
    filterResponses(:,(i-1)*3+1:i*3) = R;
%     figure(1);
%     subplot(4,5,i);
%     imagesc(imfilter(L,filterBank{i}));
%     figure(2);
%     subplot(4,5,i);
%     imagesc(imfilter(a,filterBank{i}));
%     figure(3);
%     subplot(4,5,i);
%     imagesc(imfilter(b,filterBank{i}));
end

end

