simFlag = setSimFlag('basic');

[op, opreport] = actrim('wl', 'v', 350, 'alt', 4000);

ssList              = struct();
ssList.io.ac{1}     = {'input', 'RollInput', 1};
ssList.io.ac{2}     = {'input', 'PitchInput', 1};
ssList.io.ac{3}     = {'input', 'YawInput', 1};
ssList.io.ac{4}     = {'input', 'ThrottleInput', 1};
ssList.io.ac{5}     = {'output', 'Aircraft', 1, 'EOM_Bus.speedWindX_mps'};
ssList.io.ac{6}     = {'output', 'Aircraft', 1, 'EOM_Bus.angleOfAttack_deg'};
ssList.io.ac{7}     = {'output', 'Aircraft', 1, 'EOM_Bus.angleOfSideslip_deg'};
ssList.io.ac{8}     = {'output', 'Aircraft', 1, 'EOM_Bus.angularSpeedBodyX_rps'};
ssList.io.ac{9}     = {'output', 'Aircraft', 1, 'EOM_Bus.angularSpeedBodyY_rps'};
ssList.io.ac{10}    = {'output', 'Aircraft', 1, 'EOM_Bus.angularSpeedBodyZ_rps'};
ssList.io.ac{11}    = {'output', 'Aircraft', 1, 'EOM_Bus.eulerPhi_deg'};
ssList.io.ac{12}    = {'output', 'Aircraft', 1, 'EOM_Bus.eulerTheta_deg'};
ssList.io.ac{13}    = {'output', 'Aircraft', 1, 'EOM_Bus.altitude_m'};

linss = getLinModel('ADMIRE', ssList, op);

% Select Input & Output
selInd.input    = [2];
selInd.output   = [5, 2];
selInd.state    = [2, 7];

spMode = ss(linss.ac.A(selInd.state, selInd.state), linss.ac.B(selInd.state, selInd.input), linss.ac.C(selInd.output, selInd.state), linss.ac.D(selInd.output, selInd.input));
spMode.OutputName = linss.ac.OutputName(selInd.output);
spMode.StateName = linss.ac.StateName(selInd.state);
spMode.InputName = linss.ac.InputName(selInd.input);

% % % Add Missing States as Outputs
% % extC        = [spMode.C; eye(numel(spMode.StateName))];
% % extN        = [spMode.OutputName; spMode.StateName];
% % [C, ia, ic] = unique(extC, "rows");
% % extC        = extC(ia, :);
% % extN        = extN(ia);
% % extD        = [spMode.D; zeros(numel(ic) - numel(ia) + 1, numel(spMode.InputName))];
% % extSPMode   = ss(spMode.A, spMode.B, extC, extD, ...
% %     'StateName', spMode.StateName, 'OutputName', extN, 'InputName', spMode.InputName);

% Input Designation
timeVector = 0:0.01:10;
u = zeros(numel(timeVector), numel(spMode.InputName));
u(:, 1) = 1;

% State Initial Values
x0 = zeros(numel(spMode.StateName), 1);

% Calculate Response
[yOut, tOut, xOut] = lsim(spMode, u, timeVector, x0);

% Select Input State and Output
plotIOS.input   = [1];
plotIOS.output  = [1, 2];
plotIOS.state   = [1, 2];

%% Plot
figure('Name', 'Inputs', 'NumberTitle', 'off');
for iter = 1:numel(plotIOS.input)
    subplot(numel(plotIOS.input), 1, iter);
    plot(timeVector, u(:, plotIOS.input(iter)));
    xlabel('Time (s)');
    ylabel(strrep(spMode.InputName(plotIOS.input(iter)), '_', ' '));
end

figure('Name', 'States', 'NumberTitle', 'off');
for iter = 1:numel(plotIOS.state)
    subplot(numel(plotIOS.state), 1, iter);
    plot(timeVector, xOut(:, plotIOS.state(iter)));
    xlabel('Time (s)');
    ylabel(strrep(spMode.StateName(plotIOS.state(iter)), '_', ' '));
end

figure('Name', 'Outputs', 'NumberTitle', 'off');
for iter = 1:numel(plotIOS.output)
    subplot(numel(plotIOS.output), 1, iter);
    plot(timeVector, yOut(:, plotIOS.output(iter)));
    xlabel('Time (s)');
    ylabel(strrep(spMode.OutputName(plotIOS.output(iter)), '_', ' '));
end