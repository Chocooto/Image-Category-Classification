%% Image Classification
% Bag of Visual Words(HOG + kmeans) + SVM(EMD kernel)
% Data set: Caltech 101
% We have pre-computed the EMD kernel matrix and load the matrix directly
% in this script.
% The calculation of EMD kernel matrix is extremely time-comsuming

% Huayu Zhang, May 2015

addpath('utils');
addpath('imagefeatures');
addpath('svmdesign');
addpath('pcas');
run(fullfile('vlfeat','toolbox','vl_setup.m'));

%% parameters
% file I/O 
rootFolder = fullfile('../data','Caltech','101_ObjectCategories');
istrim = true;
% random 
% rng(1);
% classes
NumberSelect = 3; 
% ClassIndices = randperm(size(classes,1),NumberSelect);
ClassIndices = [2, 5, 7];
% feature extraction
BoWParams = struct('DetectorName','SURF','DescriptorName','HOG',...
    'DescriptorParams',struct('SURFSize',64),'k',200,'MaxFeatures',200,'type','tf');
% KPCA
th = 0.95;
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
    testingLabels, C] = bagOfVisualWords(trainingSets,testingSets,BoWParams);
% KPCA
load('emdk_surf.mat'); %Ktrain, Ktest
[trainingKPCAs, testingKPCAs] = kernelPCA(Ktrain, Ktest, th);
% SVM training
SVMMdl = fitcecoc(trainingKPCAs, trainingLabels,'Learners',svmOptions);
% cross validation
CVMdl = crossval(SVMMdl);
oosLoss = kfoldLoss(CVMdl);
fprintf('Cross Validation Error: %f.\n',oosLoss);
% prediction
trainingPredictions = predict(SVMMdl,trainingKPCAs);
testingPredictions = predict(SVMMdl,testingKPCAs);
% confusion matrix
Ctrain = confusionmat(trainingLabels,trainingPredictions);
Ctest = confusionmat(testingLabels,testingPredictions);
dispConfusionMatrices(Ctrain,Ctest);