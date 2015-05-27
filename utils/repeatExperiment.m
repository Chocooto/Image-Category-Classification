function [CM_train_stat,CM_test_stat,CM_train_m,CM_test_m] = repeatExperiment(script, repeat)
% REPEATEXPERIMENT 
% ----------------------------------------------------------
% [CM_train_stat,CM_test_stat,CM_train_m,CM_test_m] = repeatExperiment(script, repeat)
% script: MATLAB script(string)
% repeat: how many times repeating the experiment 

% CM_*_stat: statistics mu, sigma
% CM_*_m: CM record all each repeations

% Huayu Zhang, May 2015

CMtrain = cell(repeat,1);
CMtest = cell(repeat,1);
for r = 1:repeat
    fprintf(1,'SURF:%d.\t',r);
    tic;
    eval(script);
    CMtrain{r} = Ctrain(:);
    CMtest{r} = Ctest(:);
    toc;
    clear SVMMdl;
end

CM_train_m = cat(2,CMtrain{:});
CM_test_m = cat(2,CMtest{:});
CM_train_stat.mu = reshape(mean(CM_train_m,2),size(Ctrain));
CM_train_stat.sigma = reshape(std(CM_train_m,0,2),size(Ctrain));
CM_test_stat.mu = reshape(mean(CM_test_m,2),size(Ctest));
CM_test_stat.sigma = reshape(std(CM_test_m,0,2),size(Ctest));


