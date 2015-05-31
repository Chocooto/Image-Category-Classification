%% SVM experiments

addpath('utils');
repeat = 10; % repeat the experiment 10 times

% without kPCA
% SURF
[CM_SURF_SVM_train_stat,CM_SURF_SVM_test_stat,CM_SURF_train_record,...
    CM_SURF_test_record] = repeatExperiment('demo6_svm_surf', repeat);
fprintf(1,'SURF + SVM\n');
dispConfusionMatrices(CM_SURF_SVM_train_stat,CM_SURF_SVM_test_stat);

% HOG
fprintf(1,'HOG + SVM\n');
[CM_HOG_SVM_train_stat,CM_HOG_SVM_test_stat,CM_HOG_train_record,...
    CM_HOG_test_record] = repeatExperiment('demo6_svm_hog', repeat);
dispConfusionMatrices(CM_HOG_SVM_train_stat,CM_HOG_SVM_test_stat);

% % with kPCA
% % SURF
% fprintf(1,'SURF + EMD + KPCA(0.95) + SVM\n');
% [CM_SURF_kSVM_train_stat,CM_SURF_kSVM_test_stat,CM_SURF_kSVM_train_record,...
%     CM_SURF_kSVM_test_record] = repeatExperiment('demo05_svm_surf_emd', repeat/2);
% dispConfusionMatrices(CM_SURF_kSVM_train_stat,CM_SURF_kSVM_test_stat);
% 
% % HOG
% fprintf(1,'SURF + HOG + KPCA(0.95) + SVM\n');
% [CM_HOG_kSVM_train_stat,CM_HOG_kSVM_test_stat,CM_HOG_kSVM_train_record,...
%     CM_HOG_kSVM_test_record] = repeatExperiment('demo02_svm_hog_emd', repeat/2);
% dispConfusionMatrices(CM_HOG_kSVM_train_stat,CM_HOG_kSVM_test_stat);
