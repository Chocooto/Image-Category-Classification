%% Image Classification
% Bag of Visual Words(HOG + kmeans) + SVM
% Data set: Caltech 101
% Load Images

% Huayu Zhang, May 2015

addpath('./utils');
addpath('./imagefeatures');
run(fullfile('vlfeat','toolbox','vl_setup.m'));

%% parameters
% file I/O 
rootFolder = fullfile('../data','Caltech','101_ObjectCategories');
istrim = true;
% random 
rng(1);
% classes
NumberSelect = 6; 
% ClassIndices = randperm(size(classes,1),NumberSelect);
ClassIndices = [1,2,4,5,7,96]; % 200+
% feature extraction
BoWParams = struct('DetectorName','SURF','DescriptorName','HOG',...
    'DescriptorParams',struct('BlockSize',[4,4]),'k',200,'MaxFeatures',200,'type','tf');
% SVM Design
percentage = [0.4]; % percentage for training
svmOptions = templateSVM('BoxConstraint', 1, 'KernelFunction', 'linear',...
    'standardize',1);

%% Load Images
imgSets = loadImages(rootFolder, ClassIndices, istrim);
dispSamples(imgSets, 1); % display sample

%% Learning
% division
[trainingSets, testingSets] = partition(imgSets, percentage, 'randomize');
% feature extration
[trainingFeatures, trainingLabels, testingFeatures, ...
    testingLabels] = bagOfVisualWords(trainingSets,testingSets,BoWParams);
fontsize = 20;
Nc = numel(unique(trainingLabels));

% SVM training
SVMMdl = fitcecoc(trainingFeatures, trainingLabels,'Learners',svmOptions);
% cross validation
CVMdl = crossval(SVMMdl);
oosLoss = kfoldLoss(CVMdl);
fprintf('Cross Validation Error: %f.\n',oosLoss);
% prediction
trainingPredictions = predict(SVMMdl,trainingFeatures);
testingPredictions = predict(SVMMdl,testingFeatures);
% confusion matrix
Ctrain = confusionmat(trainingLabels,trainingPredictions);
Ctest = confusionmat(testingLabels,testingPredictions);
dispConfusionMatrices(Ctrain,Ctest);