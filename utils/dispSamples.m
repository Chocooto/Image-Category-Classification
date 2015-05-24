function dispSamples(imgSets, hf)
% DISPSAMPLES : SHOW ONE IMAGE OF EACH CLASS
% -------------------------------------------
% dispSamples(imgSets, hf)
% imgSets: the image set class
% hf : handle of figure

% Huayu Zhang, May 2015

Nc = numel(imgSets);
imgs = cell(1,Nc);
for c = 1:Nc
    imgs{c} = read(imgSets(c),1);
end

figure(hf);
n = ceil(sqrt(Nc));
for c = 1:Nc
    subplot(n,n,c);
    imshow(imgs{c});
    xlabel(imgSets(c).Description);
end
