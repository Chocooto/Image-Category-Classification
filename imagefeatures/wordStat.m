function tf = wordStat(features, C)
% WORDSTAT: VISUAL WORDS STATISTICS
% ------------------------------------------------
% tf = wordStat(features, C, type)
% features : all features of an image
% C : centroid position of clusters (k x p)
% tf : vector (1 x p) term frequency

% Huayu Zhang, May 2015

nf = size(features,1); N = size(C,1); tf = zeros(1,N);
for i = 1:nf
    word = encodeVisualWord(features(i,:), C);
    tf(word) = tf(word) + 1;
end
tf = tf / sum(tf,2);