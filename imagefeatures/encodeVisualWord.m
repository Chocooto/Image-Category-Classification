function word = encodeVisualWord(feature, C)
% ENCODEVISUALWORD: DETERMINE THE CLUSTER OF THE FEATURES
% -------------------------------------------------------------
% word = encodeVisualWord(feature, C)
% features: feature vector (1-by-p)
% C:centroid locations (k-by-p)

% Huayu Zhang, May 2015
features_x_k = repmat(feature,[size(C,1),1]);
df = features_x_k - C;
dist = sum(df.^2,2);
word = find(dist == min(dist));