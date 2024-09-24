clc;
clear all;
close all;
%---------------------------------------
numClasses =2;
numEpochs = 100;
load('Plum_data100x10x2c.mat')
load('Label_Mat2c.mat')


%Convert the numeric labels to categorical.
Label_Mat = categorical(Label_Mat);

numCubes = size(imageData,1);

% % Set the random number generator seed for reproducibility
% rng(123); % Choose any seed value you prefer

%% Randomly divide the patches into training and test data sets.
[trainingIdx,valIdx,testIdx] = dividerand(numCubes,0.7,0,0.3);
dataInputTrain = imageData(trainingIdx,:,:,:);
dataLabelTrain = Label_Mat(trainingIdx,1);
dataInputTest = imageData(testIdx,:,:,:);
dataLabelTest = Label_Mat(testIdx,1);

[accuracy] = BruiseFinder(numClasses,numEpochs,imageData,dataInputTrain,dataLabelTrain,dataInputTest,dataLabelTest);


%--------------function----------------------
function [dataInputTrain,dataLabelTrain,dataInputTest,dataLabelTest]  = traintest_split(numCubes,imageData,Label_Mat)
[trainingIdx,valIdx,testIdx] = dividerand(numCubes,0.7,0,0.3);
dataInputTrain = imageData(trainingIdx,:,:,:);
dataLabelTrain = Label_Mat(trainingIdx,1);
dataInputTest = imageData(testIdx,:,:,:);
dataLabelTest = Label_Mat(testIdx,1);
end
%--------------function----------------------
function data = loadData(files)
    numFiles = numel(files);
    data = cell(1, numFiles);
    for i = 1:numFiles
        matData = load(fullfile(files(i).folder, files(i).name));
        % Assuming the variable name in MAT file is 'HSImg_cut'
        data{i} = matData.HSImg_cut;
    end
end
%----------------------------------------------