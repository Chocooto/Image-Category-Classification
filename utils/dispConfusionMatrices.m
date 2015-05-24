function dispConfusionMatrices(Ctrain,Ctest)
% DISPLAY CONFUSION MATRICES WITH PERCENTAGE
% -------------------------------------------
% dispConfusionMatrices(Ctrain,Ctest)

% Huayu Zhang, May 2015

Ctrain_pct = Ctrain ./ repmat(sum(Ctrain,2),[1,size(Ctrain,2)]);
Ctest_pct = Ctest ./ repmat(sum(Ctest,2),[1,size(Ctrain,2)]);

disp('Confusion matrix(Training)');
disp(Ctrain);
disp(Ctrain_pct);
disp('Confusion matrix(Test)');
disp(Ctest);
disp(Ctest_pct);

