function [Ktrain, Ktest] = emdkernel(trainingFeatures, testingFeatures, params)
% EMDKERNEL : COMPUTE EARTH MOVER'S DISTANCE KERNEL MATRIX
% ---------------------------------------------------------
% K = emdkernel(trainingFeatures, testingFeatures, params)
% trainingFeatures: n1 x p matrix
% testingFeatures: n2 x p matrix
% params : a struct(D(distance matrix),type(how to calculate A:'auto'|'manual'),A)
% [Ktrain, Ktest] : kernel matrix (n1 x n1) (n2 x n1)

% Huayu Zhang, May 2015

D = params.D;
n1 = size(trainingFeatures,1);
n2 = size(testingFeatures,1);
Ktrain = zeros(n1, n1);
Ktest = zeros(n2, n1);
fprintf(1,'Begin calculating EMD kernel...\n');
fprintf(1,'Training Data...\n');
for i = 1:n1
    fprintf(1,'Line %d.\n',i);tic;
    for j = (i+1):n1
        Ktrain(i,j) = emd_hat_gd_metric_mex(trainingFeatures(i,:)',trainingFeatures(j,:)',D,0);
        Ktrain(j,i) = Ktrain(i,j);
    end
    toc;
end

fprintf(1,'Testing Data...\n');
for i = 1:n2
    fprintf(1,'Line %d.\n',i);tic;
    for j = 1:n1
        Ktest(i,j) = emd_hat_gd_metric_mex(testingFeatures(i,:)',trainingFeatures(j,:)',D,0);
    end 
    toc;
end

if strcmp(params.type,'auto')
    A = mean(Ktrain(:));
else 
    A = params.A;
end

Ktrain = exp(-Ktrain/A);
Ktest = exp(-Ktest/A);