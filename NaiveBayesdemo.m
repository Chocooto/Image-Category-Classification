load data
NB=NaiveBayes.fit(trainingFeatures,trainingLabels,'Distribution','kernel');

trainingPredictions=NB.predict(trainingFeatures,'HandleMissing','on');
testPredictions = NB.predict(testFeatures,'HandleMissing','on');

Ctrain = confusionmat(trainingLabels,trainingPredictions);
Ctest = confusionmat(testLabels,testPredictions);

disp('Confusion matrix(Training)');
disp(Ctrain);
disp('Confusion matrix(Test)');
disp(Ctest);
