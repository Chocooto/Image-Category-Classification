%% Image Classification - Preprocessing
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
NumberSelect = 3; 
% ClassIndices = randperm(size(classes,1),NumberSelect);
ClassIndices = [2, 5, 7];
% feature extraction
BoWParams = struct('DetectorName','SURF','DescriptorName','Auto',...
    'DescriptorParams',struct('SURFSize',128),'k',200,'MaxFeatures',200,'type','tf');
% SVM Design
percentage = [0.2]; % percentage for training
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