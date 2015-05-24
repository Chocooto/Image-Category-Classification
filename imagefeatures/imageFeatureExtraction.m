function [features, varargout] = imageFeatureExtraction(I, DetectorName, DescriptorName, DescriptorParams, MaxFeatures)
% IMAGEFEATUREEXTRACTION
% ------------------------------------------------------------------
% [features, varargout] = imageFeatureExtraction(I, DetectorName, DescriptorName, DescriptorParams, MaxFeatures)
% I : image
% DetectorName: 'FAST','MinEigen','Harris','SURF','BRISK','MSER'
% 'FAST':Features from accelerated segment test
% 'MinEigen':Minimum eigenvalue algorithm
% 'Harris':Harris affine region detector
% 'SURF':Speeded up robust features
% 'BRISK':Binary Robust Invariant Scalable Keypoints
% 'MSER':Maximally stable extremal regions
% DescriptorName: 'HOG','Auto','BRISK','FREAK','SURF','Block'
% 'HOG':Histogram of oriented gradients. If this method is used, the 
% DescriptorParams should have a field named 'BlockSize'. Otherwise, the
% DsecriptorParams should have a field named 'SURFSize'
% Auto: Automatically select certain algorithm
% FREAK: Fast Retina Keypoint
% MaxFeatures: Max number of features for each image

% Huayu Zhang, May 2015

% detect features
if strcmp(DetectorName,'FAST')
    points = detectFASTFeatures(I);
elseif strcmp(DetectorName,'MinEigen')
    points = detectMinEigenFeatures(I);
elseif strcmp(DetectorName,'Harris')
    points = detectHarrisFeatures(I);
elseif strcmp(DetectorName,'SURF')
    points = detectSURFFeatures(I);
elseif strcmp(DetectorName,'BRISK')
    points = detectBRISKFeatures(I);
elseif strcmp(DetectorName,'MSER')
    points = detectMSERFeatures(I);
else
    error('Incorrect Detector Name.\n');
end

% truncate points
points = points.selectStrongest(MaxFeatures);

% describe features
if strcmp(DescriptorName,'HOG')
    [features, varargout{1}, varargout{2}] = extractHOGFeatures(I,points,...
        'BlockSize',DescriptorParams.BlockSize);
else
    [features, varargout{1}] = extractFeatures(I,points,'Method',DescriptorName,...
        'SURFSize',DescriptorParams.SURFSize);
end
