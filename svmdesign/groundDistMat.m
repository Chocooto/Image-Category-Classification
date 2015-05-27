function D = groundDistMat(C)
% GROUNDDISTMAT : GOMPUTE GROUND DISTANCE MATRIX
% ---------------------------------------------------
% D = groundDistMat(C)
% C: centroid positions of clusters (n x p)
% D: distance matrix (n x n)

% Huayu Zhang, May 2015
[n,~] = size(C);
D = zeros(n);
for i = 1:n
    for j = (i+1):n
        D(i,j) = norm(C(i,:)-C(j,:),2);
        D(j,i) = D(i,j);
    end
end