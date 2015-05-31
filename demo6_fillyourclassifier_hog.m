%% Image Classification
% Bag of Visual Words(HOG + kmeans) + Your Classifier
% Data set: Caltech 101
% Load Images

% In this script, you need to incorporate your classifier. See details in 
% line 29~32 and line 45~46.

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

%% Bayes Design
percentage = [0.4]; % percentage for training
% Generate a classifier template here. For example,
% bayesOptions = templateNaiveBayes('DistributionNames', 'kernel', 'Kernel', 'normal');
% svmOptions = templateSVM('BoxConstraint', 1, 'KernelFunction', 'linear',...
%    'standardize',1);

%% Load Images
imgSets = loadImages(rootFolder, ClassIndices, istrim);
dispSamples(imgSets, 1); % display sample

%% Learning
% division
[trainingSets, testingSets] = partition(imgSets, percentage, 'randomize');
% feature extration
[trainingFeatures, trainingLabels, testingFeatures, ...
    testingLabels] = bagOfVisualWords(trainingSets,testingSets,BoWParams);
% Configure yourClassifier in line 29~32
BMdl = fitcecoc(trainingFeatures, trainingLabels,'Learners',yourClassifier);
% cross validation
CVMdl = crossval(BMdl);
oosLoss = kfoldLoss(CVMdl);
fprintf('Cross Validation Error: %f.\n',oosLoss);
% prediction
trainingPredictions = predict(BMdl,trainingFeatures);
testingPredictions = predict(BMdl,testingFeatures);
% confusion matrix
Ctrain = confusionmat(trainingLabels,trainingPredictions);
Ctest = confusionmat(testingLabels,testingPredictions);
dispConfusionMatrices(Ctrain,Ctest);