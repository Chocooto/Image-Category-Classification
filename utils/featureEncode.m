function [features, labels] = featureEncode(imgSets, bag)
% FEATUREENCODE 
% --------------------------------------------------------
% [features, labels] = featureEncode(imgSets, bag)
% imgSets : image sets
% bag : bag of words
% features : N * D(number of words)
% labels : N * 1 cell

% Huayu Zhang, May 2015
features = cell(numel(imgSets),1);
labels = {};
for c = 1:numel(imgSets)
    features{c} = zeros(imgSets(c).Count,bag.VocabularySize);
    labels = [labels;repmat({imgSets(c).Description},[imgSets(c).Count,1])];
    for i = 1:imgSets(c).Count
        features{c}(i,:) = encode(bag, read(imgSets(c),i));
    end
end

features = cell2mat(features);