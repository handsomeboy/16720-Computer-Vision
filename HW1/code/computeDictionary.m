 
% Does computation of the filter bank and dictionary, and saves
% it in dictionary.mat 


load('../dat/traintest.mat'); 
[filterBank,dictionary] = getFilterBankAndDictionary(train_imagenames);

save('dictionary.mat','filterBank','dictionary'); 