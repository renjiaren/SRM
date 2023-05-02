classdef ModelRegenerate
    properties
        creobridgePath
        tempFolderPath
        modelPath
        pauseTime
        parameters
        value
        modelName
        parameterAndValue
    end
    
    methods
        function obj = ModelRegenerate(creobridgePath, tempFolderPath, ...
                modelPath, modelName, pauseTime, parameters, value)
            obj.creobridgePath = creobridgePath;
            obj.tempFolderPath = tempFolderPath;
            obj.modelPath = modelPath;
            obj.modelName = modelName;
            obj.pauseTime = pauseTime;
            obj.parameters = parameters;
            obj.value = value;
            for c = 1:length(obj.parameters)
                obj.parameterAndValue = sprintf('%s%s=%f;', obj.parameterAndValue, obj.parameters(c), obj.value(c));
            end
        end
        
        function creoCommandReady(obj)
            fid = fopen([obj.tempFolderPath, '\CreoCommandReady.txt'], 'w');
            fprintf(fid, '%s', '');
            fclose(fid);
            pause(obj.pauseTime);
        end
        
        function loadModel(obj)
            fid = fopen([obj.tempFolderPath, '\CreoCommand.txt'], 'w');
            fprintf(fid, '%s\n%s\\%s%s', 'LOAD_MODEL', obj.modelPath, obj.modelName, '.prt');
            fclose(fid);
            pause(obj.pauseTime);
            creoCommandReady(obj);
        end
        
        function setParameters(obj)
            fid = fopen([obj.tempFolderPath, '\CreoCommand.txt'], 'w');
            fprintf(fid, '%s\n', 'SET_PARAMT_REGEN');
            for c = 1:length(obj.parameters)
                fprintf(fid, '%s=%f\n', obj.parameters(c), obj.value(c));
                %obj.parameterAndValue = [obj.parameterAndValue obj.parameters(c) obj.value(c)];
                obj.parameterAndValue = [1];
            end
            fclose(fid);
            pause(obj.pauseTime);
            creoCommandReady(obj);
        end
        
        function saveModel(obj)
            fid = fopen([obj.tempFolderPath, '\CreoCommand.txt'], 'w');
            fprintf(fid, '%s', 'SAVE_MODEL');
            fclose(fid);
            pause(obj.pauseTime);
            creoCommandReady(obj);
        end
        
        function saveExtraModel(obj)
            path = sprintf('%s%s%s', obj.modelPath, '\', obj.parameterAndValue);
            mkdir(path);
            fid = fopen([obj.tempFolderPath, '\CreoCommand.txt'], 'w');
            fprintf(fid, '%s\n%s', 'EXPORT_MODEL_CREO', path);
            fclose(fid);
            pause(obj.pauseTime);
            creoCommandReady(obj);
        end
        
        function exportModel(obj)
            fid = fopen([obj.tempFolderPath, '\CreoCommand.txt'], 'w');
            fprintf(fid, '%s\n%s\\%s%s', 'EXPORT_MODEL_SAT', obj.modelPath, obj.modelName, '.sat');
            fclose(fid);
            pause(obj.pauseTime);
            creoCommandReady(obj);
        end
        
        function stop(obj)
            fid = fopen([obj.tempFolderPath, '\CreoCommand.txt'], 'w');
            fprintf(fid, '%s', 'STOP');
            fclose(fid);
            pause(obj.pauseTime);
            creoCommandReady(obj);
        end
        
        function execute(obj)
            obj.loadModel();
            obj.setParameters();
            obj.saveModel();
            obj.saveExtraModel();
            obj.exportModel();
        end
    end
end

