clc;
clear
% import ModelRegenerate
% import GPUCalculate

creobridgePath = 'E:\SRM\SRM\creobridge5';
tempFolderPath = 'D:\Temp';
modelPath = 'D:\Model';
modelName = 'Grain';
IBSPath = 'E:\SRM\SRM\IBS';
pauseTime = 1;
parameters = ["L_1", "L_2", "Alpha_1", "Beta_1"];
value = [200, 300, 60.52, 70.98];
m = ModelRegenerate(creobridgePath, tempFolderPath, modelPath, modelName, IBSPath, pauseTime, parameters, value);
%m.execute();

k = GPUCalculate(IBSPath, modelName);
k.execute();