function [trainingFeatures, trainingLabels, testingFeatures, ...
    testingLabels] = bagOfVisualWords(trainingSets,testingSets,BoWParams)
% BAGOFVISUALWORDS
% ------------------------------------------------------------
% [trainingFeatures, trainingLabels, testingFeatures, testingLabels] = ...
% bagOfVisualWords(imgSets,testingSets,BoWParams)
% imgSets : image sets
% BoWParams: Bag of Words parameters. struct
% (DetectorName,DescriptorName,DescriptorParams,MaxFeatures,k,type)
% DetectorName:'FAST','MinEigen','Harris','SURF','BRISK','MSER'
% DescriptorName:'HOG','Auto','BRISK','FREAK','SURF','MSER'
% k:Number of clusters
% MaxFeatures: Max number of features for each image
% type:'tf'|'tfidf'. 'tf':term frequency, tfidf:term frequency inverse
% document frequency
% C: centroid positions of clusters

% Huayu Zhang, May 2015
[DetectorName,DescriptorName,DescriptorParams,k, MF] = deal(BoWParams.DetectorName,...
    BoWParams.DescriptorName,BoWParams.DescriptorParams,BoWParams.k,...
    BoWParams.MaxFeatures);

nc = numel(trainingSets); features = cell(nc,1);
% forming visual words
for i = 1:nc
    features{nc} = [];
    ni = trainingSets(i).Count;
    for j = 1:ni
        I = read(trainingSets(i),j);
        if size(I,3) ~= 1
            I = rgb2gray(I);
        end
        features_oneimg = imageFeatureExtraction(I, DetectorName,...
            DescriptorName, DescriptorParams, MF);
        features{i} = [features{i};features_oneimg];
    end
    fprintf('Image Set %d(%s) has %d features.\n',i,trainingSets(i).Description,...
        size(features{i},1));
end
fprintf(1,'k-means Clustering. Number of words:%d\n',k);
features = cell2mat(features);
C = vl_kmeans(features',k); C = C';
fprintf(1,'Clustering finished.\nEncoding...\n');
% encoding
trainingFeatures = zeros(sum([trainingSets.Count]),k);
trainingLabels = cell(sum([trainingSets.Count]),1);
testingFeatures = zeros(sum([testingSets.Count]),k);
testingLabels = cell(sum([testingSets.Count]),1);
count = 1;
% training data
for i = 1:nc
   ni = trainingSets(i).Count;
   for j = 1:ni
       I = read(trainingSets(i),j);
       if size(I,3) ~= 1
            I = rgb2gray(I);
       end
       train1i = imageFeatureExtraction(I, DetectorName,...
            DescriptorName, DescriptorParams, MF);
       tf = wordStat(train1i, C);
       trainingFeatures(count,:) = tf;
       trainingLabels{count,1} = trainingSets(i).Description;
       count = count + 1;
   end
end

% testing data
count = 1;
for i = 1:nc
    ni = testingSets(i).Count;
    for j = 1:ni
        I = read(testingSets(i),j);
        if size(I,3) ~= 1
            I = rgb2gray(I);
        end
        test1i = imageFeatureExtraction(I, DetectorName,...
            DescriptorName, DescriptorParams, MF);
        tf = wordStat(test1i, C);
        testingFeatures(count,:) = tf;
        testingLabels{count,1} = testingSets(i).Description;
        count = count + 1;
    end
end

% TF or TFIDF
if strcmp(BoWParams.type,'tfidf')
    idf = invDocFreq(trainingFeatures);
    idf = repmat(idf,[size(trainingFeatures,1),1]);
    trainingFeatures = trainingFeatures .* idf;
    idf = invDocFreq(testingFeatures);
    idf = repmat(idf,[size(testingFeatures,1),1]);
    testingFeatures = testingFeatures .* idf;
end