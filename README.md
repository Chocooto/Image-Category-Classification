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

The classes can be chosen arbitrarily by tuning _ClassIndices_. In the demo, I choose classes 'Faces','Airplane' and 'Motorbike'.

The current package has 6 demos,
<ol>
    <li> __demo01_svm_hog.m__ : HOG + SVM </li>
    <li> __demo02_svm_hog_emd.m__ : HOG + EMD-KPCA + SVM </li>
    <li> __demo03_svm_hog_emd_vload.m__: HOG + EMD-KPCA (loading pre-computed kernel matrix) + SVM
    </li>
    <li> __demo04_svm_surf.m__ : SURF + SVM </li>
    <li> __demo05_svm_surf_emd.m__ : SURF + EMD-KPCA + SVM </li>
    <li> __demo06_svm_surf_emd_vload.m__: SURF + EMD-KPCA (loading pre-computed kernel matrix) + SVM
    </li>
</ol>

The computation of EMD kernel matrix is extremely time-comsuming, so it is wise to pre-compute and store it.

__svm_exp.m__ is a test script, demo01,demo02(demo04,demo05) will be executed for 10(5) times. We then calculate the mean and standard deviation.

Matlab R2014B, Windows 7 OS* 64-bit.
