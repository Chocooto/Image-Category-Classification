clear;
load('data.mat');
%% Training
%����trainingLabels
s =length(trainingLabels);
target = zeros(s,3);
for i = 1:s
    if strcmp(trainingLabels(i,1),'Faces')
        temp = 1;
    end
    if strcmp(trainingLabels(i,1),'Motorbikes')
        temp = 2;
    end
    if strcmp(trainingLabels(i,1),'airplanes')
        temp = 3;
    end
    target(i,temp)=1;
end

%����������:���㣬��һ��500���ڵ㣬�ڶ���(���ز�)20�����ɵ�����������3�����ڶ��㼤�������logsig��ѵ���������ݶ��½�����Ӧѧϰ��ѵ������
net = newff( minmax(trainingFeatures'),[20,3], { 'logsig' 'purelin' } , 'traingdx'); 

%����ѵ������
net.trainparam.show = 50 ;%��ʾ�м���������
net.trainparam.epochs = 500;%����������
net.trainparam.goal = 0.01 ;%������ѵ����Ŀ�����
net.trainParam.lr = 0.1 ;%ѧϰ��

%��ʼѵ��
net = train(net,trainingFeatures',target');

%% Testing
%���ѵ�����Ͳ��Լ����з��࣬�г�����ֱ�ĸ���
trainingPrd = sim(net,trainingFeatures');
testPrd = sim(net,testFeatures');

%% Confusion Matrix
trainingPrd=trainingPrd';
testPrd=testPrd';
trainingPredictions = cell(length(trainingPrd),1);
testPredictions= cell(length(testPrd),1);

for i=1:length(trainingPrd)
    [t,ind]=max(trainingPrd(i,:));
    if ind==1
        trainingPredictions(i,1)=cellstr('Faces');
    end
    if ind==2
        trainingPredictions(i,1)=cellstr('Motorbikes');
    end
    if ind==3
        trainingPredictions(i,1)=cellstr('airplanes');
    end
end
for i=1:length(testPrd)
    [t,ind]=max(testPrd(i,:));
    if ind==1
        testPredictions(i,1)=cellstr('Faces');
    end
    if ind==2
        testPredictions(i,1)=cellstr('Motorbikes');
    end
    if ind==3
        testPredictions(i,1)=cellstr('airplanes');
    end
end

Ctrain = confusionmat(trainingLabels,trainingPredictions);
Ctest = confusionmat(testLabels,testPredictions);

disp('Confusion matrix(Training)');
disp(Ctrain);
disp('Confusion matrix(Test)');
disp(Ctest);

