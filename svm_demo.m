%
clear;
load('data.mat');
%% SVM training
svm_opts = templateSVM('BoxConstraint', 1, 'KernelFunction', 'rbf',...
    'standardize',true);
SVMMdl = fitcecoc(trainingFeatures, trainingLabels,'Learners',svm_opts);
CVMdl = crossval(SVMMdl);
oosLoss = kfoldLoss(CVMdl);
fprintf('Cross Validation Error: %f.\n',oosLoss);

fontsize = 15;
Nc = numel(unique(trainingLabels));
for c = 1:Nc
    figure(c);
    bar(trainingFeatures((c-1)*numel(trainingLabels)/Nc+1,:));
    xlabel('Visual word index','FontSize',fontsize);
    ylabel('Frequency of occurrence','FontSize',fontsize);
    set(gca,'FontSize',fontsize);
end
%% Confusion Matrix
trainingPredictions = predict(SVMMdl,trainingFeatures);
testPredictions = predict(SVMMdl,testFeatures);

Ctrain = confusionmat(trainingLabels,trainingPredictions);
Ctest = confusionmat(testLabels,testPredictions);

Ctrain_pct = Ctrain ./ repmat(sum(Ctrain,2),[1,size(Ctrain,2)]);
Ctest_pct = Ctest ./ repmat(sum(Ctest,2),[1,size(Ctrain,2)]);
disp('Confusion matrix(Training)');
disp(Ctrain);
disp(Ctrain_pct);
disp('Confusion matrix(Test)');
disp(Ctest);
disp(Ctest_pct);