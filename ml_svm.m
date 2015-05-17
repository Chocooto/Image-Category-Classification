%% Machine Learning - Support Vector Machine
% following loadimages.m

% Huayu Zhang, May 2015 
addpath('utils');
loadimages;
% Train, Test partition
percentage = [0.6];
rng(1);
[trainingSets, testSets] = partition(imgSets, percentage, 'randomize');

% extracts SURF features 
bag = bagOfFeatures(trainingSets);

% feature encoding
[trainingFeatures, trainingLabels] = featureEncode(trainingSets, bag);
[testFeatures, testLabels] = featureEncode(testSets, bag);

% SVM training
svm_opts = templateSVM('BoxConstraint', 1.1, 'KernelFunction', 'linear',...
    'standardize',1);
SVMMdl = fitcecoc(trainingFeatures, trainingLabels,'Learners',svm_opts);
CVMdl = crossval(SVMMdl);
oosLoss = kfoldLoss(CVMdl);
fprintf('Cross Validation Error: %f.\n',oosLoss);

%% Confusion Matrix
trainingPredictions = predict(SVMMdl,trainingFeatures);
testPredictions = predict(SVMMdl,testFeatures);

Ctrain = confusionmat(trainingLabels,trainingPredictions);
Ctest = confusionmat(testLabels,testPredictions);

disp('Confusion matrix(Training)');
disp(Ctrain);
disp('Confusion matrix(Test)');
disp(Ctest);