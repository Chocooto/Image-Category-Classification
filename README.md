## Image Category Classification


This is the final project for course __Introduction to Artificial Intelligence__(CST,Tsinghua,Instructor:Jianmi Li). We experiment on the Caltech 101 data set.

The project is divided into two part.

<ol>
    <li>Feature Extraction</li>
    <li>Classification</li>
</ol>
For __Feature Extraction__, the __Bag of Words__ algorithm is applied.
For __Classification__, we would like to try the following algorithms,
<ul>
    <li>Support Vector Machine</li>
    <li>Naive Bayesian Classification</li>
    <li>Neural Network</li>
</ul>

Attn:

Download Caltech 101 [here](http://www.vision.caltech.edu/Image_Datasets/Caltech101/).

I utilize the [VLFeat](http://www.vlfeat.org/index.html) library for feature extration.

The _rootFolder_(in loadimages line 8) needs changing to fit the location of the Caltech101 data set.

The classes can be chosen arbitrarily by tuning _ClassIndices_(in loadimages line 17). In the demo, I randomly choose classes 'Faces','Airplane' and 'Motorbike'.

Run ml_svm.m,svm_hogs.m and svm_surf.m to see the result, and you can write other classifiers.
ml_svm use MATLAB default bagOfFeatures function.
svm_hogs.m use Histogram of Oriented Gaussian(HOG) as the patch feature descriptor.
svm_surf.m use Speeded up Robust Features as the patch feature descriptor.
