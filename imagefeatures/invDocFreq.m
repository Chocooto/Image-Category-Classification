function idf = invDocFreq(tfs)
% INVDOCFREQ: INVERSE DOCUMENT FREQUENCY
% ---------------------------------------------
% idf = invDocFreq(tfs)
% tfs: term frequency table (n x p)
% idf : inverse document frequency (1 x p)

booltable = tfs > 1e-6;
N = size(tfs,1);
Ni = sum(booltable,1);
idf = log(N ./ Ni);