clc;
clear

% 必填项
SRMPath = 'E:\SRM\SRM';
tempFolderPath = 'D:\Temp';
modelPath = 'D:\Model';
modelName = 'Grain';

creobridgePath = [SRMPath, '\creobridge5'];
IBSPath = [SRMPath, '\IBS'];
ModelRegeneratePath = [SRMPath, '\ModelRegenerate'];
GPUCalculatePath = [SRMPath, '\GPUCalculate'];
ooDACEPath = [SRMPath, '\ooDACE'];

addpath(genpath(ModelRegeneratePath));
addpath(genpath(GPUCalculatePath));
addpath(genpath(ooDACEPath));

pauseTime = 1;
parameters = ["L_1", "L_2", "Alpha_1", "Beta_1"];
value = [200, 300, 60.52, 70.98];

m = ModelRegenerate(creobridgePath, tempFolderPath, modelPath, modelName, IBSPath, pauseTime, parameters, value);
m.execute();

k = GPUCalculate(IBSPath, modelName);
k.execute();