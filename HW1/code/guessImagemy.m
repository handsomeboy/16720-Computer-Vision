% function: guessImage.
% param: imagename.
% return: guessImage: guessed name of this image; id: class that we are going to assign.
% index: the train_image that is most similar to test image; test_features: visualwords extracted from test image.
%% implementation
function [guessedImage] = guessImage( imagename ) 
% Given a path to a scene image, guess what scene it is
% Input:
%   imagename - path to the image
load('vision.mat');
fprintf('[Loading..]\n');
% this sentense is replaced by imread.
% image = im2double(imread(imagename));
% image = imread(imagename);
% imshow(image);
fprintf('[Getting Visual Words..]\n');
% wordMap = getVisualWords(image, filterBank, dictionary);
% during testing, to speed up this process, load .mat file rather than compute visualwords since visualwords is computed by batchToVisualWords.m
load (strcat('../dat/',strrep(imagename,'.jpg','.mat')));
% h = getImageFeaturesSPM( 3, wordMap, size(dictionary,2));
h = getImageFeatures(wordMap, size(dictionary,2));
distances = distanceToSet(h, train_features);
[~,nnI] = max(distances);
load('../dat/traintest.mat','mapping');
guessedImage = mapping{train_labels(nnI)};
fprintf('[My Guess]:%s.\n',guessedImage);
% do not show image which slows computer
% figure(1);
% imshow(image);
% title('image to classify')

end

