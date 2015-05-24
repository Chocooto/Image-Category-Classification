function [A,vars] = mypca(data)
% MYPCA : MY PRINCIPLE COMPONENT ANALYSIS
% -----------------------------------------
% [A,vars] = mypca(data)
% data : features and samples
% A : transform matrix
% vars : Variances

Sigma = cov(data);
[A, D] = eig(Sigma);

[vars, idx] = sort(diag(D),'descend');
A = A(:,idx);