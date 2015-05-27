%% Image Classification
% verify the robust of all detectors and descriptors
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
Detectors = {'FAST','MinEigen','Harris','SURF','BRISK'};
Descriptors = {'HOG','SURF'};
BoWParams = cell(numel(Detectors),numel(Descriptors));
for i = 1:numel(Detectors)
   for j = 1:numel(Descriptors)
       if strcmp(Descriptors{j},'HOG')
            BoWParams{i,j} = struct('DetectorName',Detectors{i},'DescriptorName',Descriptors{j},...
                'DescriptorParams',struct('BlockSize',[4,4]),'k',10,'MaxFeatures',30,'type','tf');
       else
            BoWParams{i,j} = struct('DetectorName',Detectors{i},'DescriptorName',Descriptors{j},...
                'DescriptorParams',struct('SURFSize',128),'k',10,'MaxFeatures',30,'type','tf'); 
       end
   end
end
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
for i = 1:numel(Detectors)
   for j = 1:numel(Descriptors)
        fprintf(1,'Detectors:%s; Descriptors:%s\n',Detectors{i},Descriptors{j});
        % feature extration
        [trainingFeatures, trainingLabels, testingFeatures, ...
            testingLabels] = bagOfVisualWords(trainingSets,testingSets,BoWParams{i,j});
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
   end
end