toggleOnOff = 'on';

if strcmpi(toggleOnOff, 'on')
    set_param('ADMIRE', 'SignalLogging', 'on');
    set_param('ADMIRE', 'SignalLoggingName', 'logsout');
else
    set_param('ADMIRE', 'SignalLogging', 'off');
end

Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/PilotInputs', 1, toggleOnOff); % RollInput
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/PilotInputs', 2, toggleOnOff); % PitchInput
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/PilotInputs', 3, toggleOnOff); % YawInput
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/PilotInputs', 4, toggleOnOff); % ThrottleInput

Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 1, toggleOnOff); % Rudder
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 2, toggleOnOff); % LEF
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 3, toggleOnOff); % LG
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 4, toggleOnOff); % Inboard Elevon Left
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 5, toggleOnOff); % Inboard Elevon Right
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 6, toggleOnOff); % Outboard Elevon Left
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 7, toggleOnOff); % Outboard Elevon Right
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 8, toggleOnOff); % Canard Left
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/ControlSurfaces', 9, toggleOnOff); % Canard Right

Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 1, toggleOnOff); % Angle of Attack
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 2, toggleOnOff); % Angle of Sideslip
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 3, toggleOnOff); % Speed
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 4, toggleOnOff); % Roll Rate
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 5, toggleOnOff); % Pitch Rate
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 6, toggleOnOff); % Yaw Rate
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 7, toggleOnOff); % Bank Angle
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 8, toggleOnOff); % Pitch Angle
Simulink.sdi.markSignalForStreaming('ADMIRE/Scopes/Active/AircraftStates', 9, toggleOnOff); % Yaw Angle

