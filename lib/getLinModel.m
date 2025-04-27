function linss = getLinModel(modelName, ssList, op)

    if nargin < 3
        sl = slLinearizer(modelName);
    else
        sl = slLinearizer(modelName, op);
    end

    linss       = struct();
    types       = fieldnames(ssList);
    
    if any(strcmpi(types, 'io'))
        % IO Models
        modelNames  = fieldnames(ssList.io);
    
        for iter = 1:numel(modelNames)
            inputCounter    = 1;
            outputCounter   = 1;
            breakCounter    = 1;
            inputList       = {};
            outputList      = {};
            breakList       = {};
    
            for iSignal = 1:numel(ssList.io.(modelNames{iter}))
                signalSpec = ssList.io.(modelNames{iter}){iSignal};
                signal = subSignal(signalSpec);
                if numel(signalSpec) == 3
                    addPoint(sl, sprintf('%s/%s', modelName, signalSpec{2}), signalSpec{3});
                elseif numel(signalSpec) == 4
                    addPoint(sl, sprintf('%s/%s', modelName, signalSpec{2}), signalSpec{3}, signalSpec{4});
                end
    
                switch lower(signalSpec{1})
                    case 'input'
                        inputList{inputCounter} = signal;
                        inputCounter = inputCounter + 1;
                    case 'output'
                        outputList{outputCounter} = signal;
                        outputCounter = outputCounter + 1;
                    case 'break'
                        breakList{breakCounter} = signal;
                        breakCounter = breakCounter + 1;
                end
            end
    
            linss.(modelNames{iter}) = getIOTransfer(sl, inputList, outputList, breakList);
        end
    end

    if any(strcmpi(types, 'lg'))
        % Loop Gain Models
        modelNames  = fieldnames(ssList.lg);
        for iter = 1:numel(modelNames)
            inputCounter    = 1;
            breakCounter    = 1;
            inputList       = {};
            breakList       = {};
    
            for iSignal = 1:numel(ssList.lg.(modelNames{iter}))
                signalSpec = ssList.lg.(modelNames{iter}){iSignal};
                signal = subSignal(signalSpec);
                if numel(signalSpec) == 3
                    addPoint(sl, sprintf('%s/%s', modelName, signalSpec{2}), signalSpec{3});
                elseif numel(signalSpec) == 4
                    addPoint(sl, sprintf('%s/%s', modelName, signalSpec{2}), signalSpec{3}, signalSpec{4});
                end
    
                switch lower(signalSpec{1})
                    case 'input'
                        inputList{inputCounter} = signal;
                        inputCounter = inputCounter + 1;
                    case 'break'
                        breakList{breakCounter} = signal;
                        breakCounter = breakCounter + 1;
                end
            end
    
            linss.(modelNames{iter}) = getLoopTransfer(sl, inputList, breakList);
        end
    end
end

function out = subSignal(s)

    if numel(s) == 3
        out = sprintf('%s/%d', s{2}, s{3});
    elseif numel(s) == 4
        out = sprintf('%s/%d[%s]', s{2}, s{3}, s{4});
    else
        return;
    end

end