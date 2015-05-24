function H = featureEntropy(w, x, nbin)
% FEATUREENTROPY : CALCULATING THE FEATURE ENTROPY
% ------------------------------------------------
% H = featureEntropy(w, x, nbin)
% w : class label
% x : value
% nbin : number of x bins

xbound = minmax(x(:)'); [lo,hi] = deal(xbound(1),xbound(2));
xbins = linspace(lo - 1e-5 * abs(lo),hi + 1e-5 * abs(hi),nbin+1);

classes = unique(w);
Nx = numel(x);
Nc = numel(classes);  % number of classes
h = zeros(1,nbin); % entropy in each xbins
nc = zeros(1,Nc); 
p = zeros(1,nbin); % probability a x in certain xbin
for i = 1:nbin
    ws = w(xbins(i) <= x & x < xbins(i+1));
    for c = 1:Nc
        nc(c) = sum(ws == classes(c));
    end
    pc = nc ./ norm(nc,1);
    h(i) = -sum(pc .* log2(pc));
    p(i) = numel(ws) / Nx;
end
h(isnan(h)) = 0;
H = dot(h,p);



