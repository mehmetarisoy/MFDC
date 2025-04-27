


set_param(bdroot, 'LoadExternalInput', 'off');
set_param(bdroot, 'LoadInitialState', 'off');

% Variant Subsystem Selection
simFlag.Scope       = 1; % 0: Off | 1: On
simFlag.FG          = false; % false: Off | true: On 
simFlag.Actuator    = 1; % 0: Directfeed | 1: 1st Order
simFlag.Input       = 0; % 0: Directfeed (From Inport) | 1: Logitech Extremen Pro 3D

% Trim
[op, opreport] = actrim('wl', 'v', 350, 'alt', 4000);

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