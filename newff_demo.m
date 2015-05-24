clear;
load('data.mat');
%% Training
%调整trainingLabels
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

%创建神经网络:三层，第一层500个节点，第二层(隐藏层)20个（可调），第三层3个，第二层激活函数采用logsig，训练函数用梯度下降自适应学习率训练函数
net = newff( minmax(trainingFeatures'),[20,3], { 'logsig' 'purelin' } , 'traingdx'); 

%设置训练参数
net.trainparam.show = 50 ;%显示中间结果的周期
net.trainparam.epochs = 500;%最大迭代次数
net.trainparam.goal = 0.01 ;%神经网络训练的目标误差
net.trainParam.lr = 0.1 ;%学习率

%开始训练
net = train(net,trainingFeatures',target');

%% Testing
%针对训练集和测试集进行分类，列出三类分别的概率
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

