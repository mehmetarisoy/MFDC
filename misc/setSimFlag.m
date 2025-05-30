function out = setSimFlag(preset)

    out = struct();
    % Options:
    % 
    % - Scope
    %       0: Disabled
    %       1: Enabled
    % - FG
    %       false: Disabled
    %       true : Enabled
    % - Actuator
    %       0: Directfeed (No Actuator)
    %       1: 1st Order Actuator (Lag Filter)
    % - Input
    %       0: Directfeed (Top-level inports are fed to the actuators or to the
    %           aerodyanmics)
    %       1: Logitech Extreme Pro 3D

    switch lower(preset)
        case 'default'
            out.Scope       = 1;
            out.FG          = false;
            out.Actuator    = 1;
            out.Input       = 0;
        case 'basic'
            out.Scope       = 1;
            out.FG          = false;
            out.Actuator    = 0;
            out.Input       = 0;
        case 'pilotedsim'
            out.Scope       = 1;
            out.FG          = true;
            out.Actuator    = 1;
            out.Input       = 1;
    end

end

