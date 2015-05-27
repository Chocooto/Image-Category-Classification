function [trainingKPCAs, testingKPCAs] = kernelPCA(Ktrain, Ktest, th)
% KERNELPCA : KERNEL PRINCIPAL COMPONENT ANALYSIS
% -----------------------------------------------------
% [trainingKPCAs, testingKPCAs] = kernelPCA(Ktrain, Ktest, th)
% Ktrain, Ktest : input matrix N1 x p, N2 x p. p : dimension of features, Ni : number of samples
% th : threshold keep th*100% information [0,1]
% trainingKPCAs, testingKPCAs : output matrix N1 x c, N2 x c

% Huayu Zhang, May 2015

N = size(Ktrain,1);
[A, D] = eig(Ktrain/N);
[vars, idx] = sort(diag(D),'descend');
A = A(:,idx);
cum = cumsum(vars);
cum_pct = cum / norm(vars,1);
T = A(:,cum_pct <= th);
trainingKPCAs = Ktrain * T;
testingKPCAs = Ktest * T;
