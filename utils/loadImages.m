function imgSets = loadImages(imgPath, ClassIndices, istrim)
% LOADIMAGES: LOAD IMAGES FROM A DATASET
% ---------------------------------------------------------
% imgSets = loadImages(imgPath, ClassIndices, istrim)
% imgPath: the path of the image dataset e.g. fullfile('../data','Caltech',
% '101_ObjectCategories');
% ClassIndices: e.g. [2,5,7]
% istrim: true|false, whether to trim the number of each image class to
% same size
% imgSets : image set class

% Huayu Zhang, May 2015

% The data set's classes. 
classes = ls(imgPath); 
classes(1:2,:) = [];

Nc = numel(ClassIndices);  % number of classes
SelectedClasses = cell(1,Nc);
SelectedPaths = cell(1,Nc);
for c = 1:Nc
    SelectedClasses{c} = strtrim(classes(ClassIndices(c),:));
    SelectedPaths{c} = fullfile(imgPath,SelectedClasses{c});
end

atom_imgset = 'SelectedPaths';
command_imgset = 'imageSet';
command1 = '[';
for c = 1:(Nc-1)
    command1 = strcat(command1, command_imgset, '(', atom_imgset, '{', ...
        num2str(c), '}),');
end
command1 = strcat(command1, command_imgset, '(', atom_imgset, '{',...
    num2str(c+1), '})]');
% Construct an array of image sets
imgSets = eval(command1);

fprintf(1,'Image descriptions and counts:\n');
{imgSets.Description}   % display all labels on one line
[imgSets.Count]         % show the corresponding count of images

if istrim
    minSetCount = min([imgSets.Count]); % determine the smallest amount of images in a category
    % Use partition method to trim the set.
    imgSets = partition(imgSets, minSetCount, 'randomize');
    % Notice that each set now has exactly the same number of images.
    fprintf(1,'Image counts after triming:\n');
    [imgSets.Count]
end
