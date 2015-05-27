function dispConfusionMatrices(Ctrain,Ctest)
% DISPLAY CONFUSION MATRICES WITH PERCENTAGE
% -------------------------------------------
% dispConfusionMatrices(Ctrain,Ctest)

% C can be a matrix or struct
% if C is a matrix, it is only a CM
% if C is a struct, it contains the statistics mu and sigma.

% Huayu Zhang, May 2015

if(isstruct(Ctrain) && isstruct(Ctest))
    Ctrain_pct.mu = Ctrain.mu ./ repmat(sum(Ctrain.mu,2),[1,size(Ctrain.mu,2)]);
    Ctest_pct.mu = Ctest.mu ./ repmat(sum(Ctest.mu,2),[1,size(Ctest.mu,2)]);
    Ctrain_pct.sigma = Ctrain.sigma ./ repmat(sum(Ctrain.mu,2),[1,size(Ctrain.mu,2)]);
    Ctest_pct.sigma = Ctest.sigma ./ repmat(sum(Ctest.mu,2),[1,size(Ctest.mu,2)]);
    disp('Confusion matrix(Training) mean');
    disp(Ctrain.mu); disp(Ctrain_pct.mu);
    disp('Confusion matrix(Training) std');
    disp(Ctrain.sigma); disp(Ctrain_pct.sigma);
    disp('Confusion matrix(Testing) mean');
    disp(Ctest.mu); disp(Ctest_pct.mu);
    disp('Confusion matrix(Testing) std');
    disp(Ctest.sigma); disp(Ctest_pct.sigma);
else
    Ctrain_pct = Ctrain ./ repmat(sum(Ctrain,2),[1,size(Ctrain,2)]);
    Ctest_pct = Ctest ./ repmat(sum(Ctest,2),[1,size(Ctest,2)]);
    disp('Confusion matrix(Training)');
    disp(Ctrain);
    disp(Ctrain_pct);
    disp('Confusion matrix(Test)');
    disp(Ctest);
    disp(Ctest_pct);
end