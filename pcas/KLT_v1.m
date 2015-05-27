function y = KLT_v1(x, th)
% KLT_V1 : KARHUNEN-LOEVE TRANSFORM
% -----------------------------------
% y = KLT_v1(x, th)
% x : input matrix N * D, D : dimension of features, N : number of samples
% th : threshold keep th*100% information [0,1]
% y : output matrix

[A,vars] = mypca(x); 
cum = cumsum(vars);
cum_pct = cum / norm(vars,1);
T = A(:,cum_pct <= th);
y = x * T;