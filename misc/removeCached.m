simulinkCache   = dir('*.slxc');
matlabASV       = dir('*.asv');

if ~isempty(simulinkCache)
    for iter = 1:numel(simulinkCache)
        delete(fullfile(simulinkCache(iter).folder, simulinkCache(iter).name))
    end
end

if ~isempty(matlabASV)
    for iter = 1:numel(matlabASV)
        delete(fullfile(matlabASV(iter).folder, matlabASV(iter).name))
    end
end

clearvars simulinkCache matlabASV iter