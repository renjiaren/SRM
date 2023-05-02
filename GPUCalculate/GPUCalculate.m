classdef GPUCalculate
    properties
        IBSPath
        modelName
    end
    
    methods
        function obj = GPUCalculate(IBSPath, modelName)
            obj.IBSPath = IBSPath
            obj.modelName = modelName
        end
        
        function calculate(obj)
            % 离散
            cmd = [obj.IBSPath, '\SATSplitter.exe ', obj.modelName, '.sat \\ normal 0.2'];
            system(cmd);
            cd(obj.IBSPath)
            % 燃面退移
            cmd = ['RunGPU.bat -10 8 1780 0.001 1 256 0'];
            system(cmd);
            % 计算内弹道             
            system('BalsZero.exe')
        end
        
        function execute(obj)
            obj.calculate();
        end
    end
end