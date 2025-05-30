if isempty(matlab.project.currentProject)
    matlab.project.loadProject('ADMIRE.prj');   
end
load("data\admireDatabase.mat");
open_system('ADMIRE.slx');


set_param(bdroot, 'LoadExternalInput', 'off');
set_param(bdroot, 'LoadInitialState', 'off');

% Variant Subsystem Selection
simFlag = setSimFlag('default');

% Trim
[op, opreport] = actrim('wl', 'v', 350, 'alt', 900);

% Define Linear Plant Input & Outputs
ssList              = struct();
ssList.io.sp{1}     = {'input', 'PitchInput', 1};
ssList.io.sp{2}     = {'output', 'Aircraft', 1, 'EOM_Bus.angularSpeedBodyY_rps'};
ssList.io.sp2{1}    = {'input', 'PitchInput', 1};
ssList.io.sp2{2}    = {'input', 'RollInput', 1};
ssList.io.sp2{3}    = {'output', 'Aircraft', 1, 'EOM_Bus.angularSpeedBodyY_rps'};
ssList.io.sp2{4}    = {'output', 'Aircraft', 1, 'EOM_Bus.angularSpeedBodyX_rps'};
% Get the Linear Model from Simulink Model
linss               = getLinModel('ADMIRE', ssList, op);