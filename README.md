## Image Category Classification

This is the final project for course __Introduction to Artificial Intelligence__(CST,Tsinghua,Instructor:Jianmi Li). We experiment on the Caltech 101 data set.

The project is divided into two part.

<ol>
    <li>Feature Extraction</li>
    <li>Classification</li>
</ol>
For __Feature Extraction__, the __Bag of Words__ algorithm is applied. Two feature descriptors, Speeded-up Robust Features (SURF) and Histogram of Oriented Gradients (HOG) are used. Besides frequency of occurrence as the features, we try a kernel PCA method combined with earth mover's distance(EMD).

For __Classification__, we would like to try the following algorithms,
<ul>
    <li>Support Vector Machine</li>
    <li>Naive Bayesian Classification</li>
    <li>Neural Network</li>
</ul>


Attn:

Download Caltech 101 [here](http://www.vision.caltech.edu/Image_Datasets/Caltech101/).

I utilize some third party toolboxes.
<ul>
    <li> [VLFeat](http://www.vlfeat.org/index.html) Computer Vision </li>
    <li> [FastEMD](http://www.ariel.ac.il/sites/ofirpele/FASTEMD/code/) Earth Mover's Distance </li>
</ul>

The _rootFolder_ needs changing to fit the location of the Caltech101 data set.

The classes can be chosen arbitrarily by tuning _ClassIndices_. In the demo, I choose 6 classes 'BACKGROUND_Google',Faces','Leopards','airplanes','watch' and 'Motorbikes'.

The current package has 4 demos,
<ol>
    <li> <strong>demo6_svm_hog.m</strong> : HOG + SVM </li>
    <li> <strong>demo6_svm_hog_emd.m</strong> : HOG + EMD-KPCA + SVM </li>
    <li> <strong>demo6_svm_surf.m</strong> : SURF + SVM </li>
    <li> <strong>demo6_svm_surf_emd.m</strong> : SURF + EMD+KPCA + SVM </li>
</ol>

<strong>demo6_fillyourclassifier_hog.m</strong> and <strong>demo6_fillyourclassifier_surf.m</strong> are two scripts containing the classification frame, but you need to configure your classifier in them. <strong>hog</strong> and <strong>surf</strong> represent two feature descriptors.

Matlab R2014B, Windows 7 OS* 64-bit.
