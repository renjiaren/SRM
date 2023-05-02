clc;
clear
import ModelRegenerate

creobridgePath = 'D:\creobridgePath';
tempFolderPath = 'D:\Temp';
modelPath = 'D:\Model';
modelName = '1';
pauseTime = 1;
parameters = ["L_1", "L_2", "Alpha_1", "Beta_1"];
value = [200, 300, 60.52, 70.98];
m = ModelRegenerate(creobridgePath, tempFolderPath, modelPath, modelName, pauseTime, parameters, value);
m.execute();