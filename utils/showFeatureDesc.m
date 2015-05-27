function showFeatureDesc(descriptors, WordSize, gap)
% SHOWFEATUREDESC : SHOW FEATURE DESCRIPTORS
% ---------------------------------------------
% showFeatureDesc(descriptors, WordSize, gap)
% descriptors: 8 x 8 x n
% Word Size: show [m n] words
% gap: insert a gap-width blank band between words.

% Huayu Zhang, May 2015

M = WordSize(1) * (8+gap) - 1;
N = WordSize(2) * (8+gap) - 1;
I = ones(M,N) * max(descriptors(:));
num = size(descriptors,3); 
idx = randperm(num,prod(WordSize));
count = 1;
for i = 1:WordSize(1)
    for j = 1:WordSize(2)
        I((i-1)*(8+gap) + (1:8),(j-1)*(8+gap) + (1:8)) = descriptors(:,:,idx(count));
        count = count + 1;
    end
end

figure; imagesc(I); set(gcf,'color','white'); axis off; axis equal; colormap(gray);