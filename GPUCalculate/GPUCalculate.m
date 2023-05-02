classdef GPUCalculate
    properties
        modelPath
    end
    
    methods
        function obj = GPUCalculate(modelPath)
            obj.modelPath = modelPath
        end
        
        function calculate(obj)
            cmd = 'C:\Windows\system32\mspaint.exe';
            system(cmd);
            cmd = 'C:\Windows\system32\SnippingTool.exe';
            system(cmd);
        end

    end
end