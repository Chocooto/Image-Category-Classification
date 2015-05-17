%% Image Classification - Preprocessing
% Data set: Caltech 101
% Load Images

% Huayu Zhang, May 2015

%% Load image sets
rootFolder = fullfile('../data','Caltech','101_ObjectCategories');

% The data set's classes. 
classes = ls(rootFolder); 
classes(1:2,:) = [];

% Several classes are chosen for learning and classification
rng(5); 
NumberSelect = 3; 
ClassIndices = randperm(size(classes,1),NumberSelect);
SelectedClasses = cell(1,NumberSelect);
SelectedPaths = cell(1,NumberSelect);
for c = 1:NumberSelect
    SelectedClasses{c} = strtrim(classes(ClassIndices(c),:));
    SelectedPaths{c} = fullfile(rootFolder,SelectedClasses{c});
end

atom_imgset = 'SelectedPaths';
command_imgset = 'imageSet';
command1 = '[';
for c = 1:(NumberSelect-1)
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

minSetCount = min([imgSets.Count]); % determine the smallest amount of images in a category

% Use partition method to trim the set.
imgSets = partition(imgSets, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
[imgSets.Count]

% display sample
imgs = cell(1,NumberSelect);
for c = 1:NumberSelect
    imgs{c} = read(imgSets(c),1);
end

figure(1);
n = ceil(sqrt(NumberSelect));
for c = 1:NumberSelect
    subplot(n,n,c);
    imshow(imgs{c});
end