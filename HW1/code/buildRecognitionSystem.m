% load training images and test images' names
train_test = load('../dat/traintest.mat'); 
% load dictionary and filterBank
load('dictionary.mat','dictionary','filterBank');
train_imagenames = train_test.train_imagenames;
train_labels = train_test.train_labels;
train_features = [];
dictionarySize = size(dictionary,2);
for i = 1:length(train_imagenames);
    sub_map_name = strrep(train_imagenames{i},'.jpg','.mat');
    load(strcat('../dat/',sub_map_name));
%     h = getImageFeaturesSPM(3,wordMap,dictionarySize);
    h = getImageFeatures(wordMap,dictionarySize);
    train_features = [train_features h];
end
save('vision.mat','filterBank','dictionary','train_features','train_labels'); 
