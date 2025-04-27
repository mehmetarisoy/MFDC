function [op, opreport] = actrim(trimType, varargin)
    %% Specify the model name
    model = bdroot;

    %% Disable external input & initial condition
    set_param(model, 'LoadExternalInput', 'off');
    set_param(model, 'LoadInitialState', 'off');

    fcnInputs = subV2S(varargin);

    if numel(size(fcnInputs.alt)) > 2
        disp('Number of dimensions cannot be more than 2');
        return;
    end
    
    %% Create the operating point specification object.
    opspec = operspec(model, size(fcnInputs.alt));
    
    % Get State Names
    for iState = 1:numel(opspec(1).States)
        if ~isempty(opspec(1).States(iState).StateName)
            ids.x.(subStateNameConvention(opspec(1).States(iState).StateName)) = iState;
        end
    end

    % Get State Names
    for iInput = 1:numel(opspec(1).Inputs)
        s = strsplit(opspec(1).Inputs(iInput).Block, '/');
        ids.u.(s{end}) = iInput;
    end


    for iter = 1:numel(fcnInputs.alt)
        opspec(iter) = subTrimDefinition(opspec(iter), trimType, ids, fcnInputs, iter);
    end
    
    %% Create the options
    opt = findopOptions('DisplayReport','iter');
    opt.OptimizationOptions.Algorithm = 'sqp';
    
    %% Perform the operating point search.
    [op, opreport] = findop(model,opspec,opt);

    %% Use the first point as the initial condition
    set_param(model, 'LoadExternalInput', 'on');
    set_param(model, 'ExternalInput', 'getinputstruct(op(1))');
    set_param(model, 'LoadInitialState', 'on');
    set_param(model, 'InitialState', 'getstatestruct(op(1))');
end

function out = subStateNameConvention(name)
    switch lower(name)
        case 'speedwindx_mps'
            out = 'vt';
        case 'angleofsideslip_rad'
            out = 'aos';
        case 'angleofattack_rad'
            out = 'aoa';
        case 'positionearthy_m'
            out = 'y';
        case 'positionearthx_m'
            out = 'x';
        case 'altitude_m'
            out = 'h';
        case 'eulertheta_rad'
            out = 'theta';
        case 'eulerpsi_rad'
            out = 'psi';
        case 'eulerphi_rad'
            out = 'phi';
        case 'angularspeedbodyx_rps'
            out = 'p';
        case 'angularspeedbodyy_rps'
            out = 'q';
        case 'angularspeedbodyz_rps'
            out = 'r';
        otherwise
            out = '';
    end
end

function out = subTrimDefinition(opspec, trimType, ids, fcnInputs, iter)
    switch lower(trimType)
        case 'wl'
            opspec.States(ids.x.vt).Known         = true;
            opspec.States(ids.x.vt).x             = fcnInputs.v(iter);
            opspec.States(ids.x.vt).Min           = 0.1;
            opspec.States(ids.x.vt).Max           = 2000;
            opspec.States(ids.x.vt).SteadyState   = true;

            opspec.States(ids.x.aoa).Known         = false;
            opspec.States(ids.x.aoa).Min           = deg2rad(-90);
            opspec.States(ids.x.aoa).Max           = deg2rad(+90);
            opspec.States(ids.x.aoa).SteadyState   = true;

            opspec.States(ids.x.aos).Known        = true;
            opspec.States(ids.x.aos).x            = 0;
            opspec.States(ids.x.aos).Min          = deg2rad(-40);
            opspec.States(ids.x.aos).Max          = deg2rad(+40);
            opspec.States(ids.x.aos).SteadyState  = true;

            opspec.States(ids.x.phi).Known        = true;
            opspec.States(ids.x.phi).x            = 0;
            opspec.States(ids.x.phi).SteadyState  = true;

            opspec.States(ids.x.theta).Known          = false;
            opspec.States(ids.x.theta).Min            = deg2rad(-90);
            opspec.States(ids.x.theta).Max            = deg2rad(+90);
            opspec.States(ids.x.theta).SteadyState    = true;

            opspec.States(ids.x.psi).Known          = true;
            opspec.States(ids.x.psi).x              = 0;
            opspec.States(ids.x.psi).Min            = deg2rad(0);
            opspec.States(ids.x.psi).Max            = deg2rad(+360);
            opspec.States(ids.x.psi).SteadyState    = true;

            opspec.States(ids.x.p).Known        = true;
            opspec.States(ids.x.p).x            = 0;
            opspec.States(ids.x.p).SteadyState  = true;

            opspec.States(ids.x.q).Known        = true;
            opspec.States(ids.x.q).x            = 0;
            opspec.States(ids.x.q).SteadyState  = true;

            opspec.States(ids.x.r).Known        = true;
            opspec.States(ids.x.r).x            = 0;
            opspec.States(ids.x.r).SteadyState  = true;

            opspec.States(ids.x.h).Known        = true;
            opspec.States(ids.x.h).x            = fcnInputs.alt(iter);
            opspec.States(ids.x.h).SteadyState  = true;
        case 'ct'
            opspec.States(ids.x.vt).Known         = true;
            opspec.States(ids.x.vt).x             = fcnInputs.v(iter);
            opspec.States(ids.x.vt).Min           = 0.1;
            opspec.States(ids.x.vt).Max           = 2000;
            opspec.States(ids.x.vt).SteadyState   = true;

            opspec.States(ids.x.aoa).Known         = false;
            opspec.States(ids.x.aoa).Min           = deg2rad(-90);
            opspec.States(ids.x.aoa).Max           = deg2rad(+90);
            opspec.States(ids.x.aoa).SteadyState   = true;

            opspec.States(ids.x.aos).Known        = true;
            opspec.States(ids.x.aos).x            = 0;
            opspec.States(ids.x.aos).Min          = deg2rad(-40);
            opspec.States(ids.x.aos).Max          = deg2rad(+40);
            opspec.States(ids.x.aos).SteadyState  = true;

            opspec.States(ids.x.phi).Known        = true;
            opspec.States(ids.x.phi).x            = deg2rad(fcnInputs.phi(iter));
            opspec.States(ids.x.phi).SteadyState  = true;

            opspec.States(ids.x.theta).Known          = false;
            opspec.States(ids.x.theta).Min            = deg2rad(-90);
            opspec.States(ids.x.theta).Max            = deg2rad(+90);
            opspec.States(ids.x.theta).SteadyState    = true;

            opspec.States(ids.x.psi).Known          = true;
            opspec.States(ids.x.psi).x              = 0;
            opspec.States(ids.x.psi).Min            = deg2rad(0);
            opspec.States(ids.x.psi).Max            = deg2rad(+360);
            opspec.States(ids.x.psi).SteadyState    = true;

            opspec.States(ids.x.p).Known        = false;
            opspec.States(ids.x.p).x            = 0;
            opspec.States(ids.x.p).SteadyState  = true;

            opspec.States(ids.x.q).Known        = false;
            opspec.States(ids.x.q).x            = 0;
            opspec.States(ids.x.q).SteadyState  = true;

            opspec.States(ids.x.r).Known        = false;
            opspec.States(ids.x.r).x            = 0;
            opspec.States(ids.x.r).SteadyState  = true;

            opspec.States(ids.x.h).Known        = true;
            opspec.States(ids.x.h).x            = fcnInputs.alt(iter);
            opspec.States(ids.x.h).SteadyState  = true;

        otherwise

    end

    % Common Settings
    opspec.States(ids.x.x).Known        = true;
    opspec.States(ids.x.x).x            = 0;
    opspec.States(ids.x.x).SteadyState  = false;

    opspec.States(ids.x.y).Known        = true;
    opspec.States(ids.x.y).x            = 0;
    opspec.States(ids.x.y).SteadyState  = false;
    
    opspec.Inputs(ids.u.RollInput).Known    = false;
    opspec.Inputs(ids.u.RollInput).u        = 0.01;
    opspec.Inputs(ids.u.RollInput).Min      = -25;
    opspec.Inputs(ids.u.RollInput).Max      = +25;

    opspec.Inputs(ids.u.PitchInput).Known    = false;
    opspec.Inputs(ids.u.PitchInput).u        = 1.5;
    opspec.Inputs(ids.u.PitchInput).Min      = -25;
    opspec.Inputs(ids.u.PitchInput).Max      = +25;

    opspec.Inputs(ids.u.YawInput).Known    = false;
    opspec.Inputs(ids.u.YawInput).u        = -0.01;
    opspec.Inputs(ids.u.YawInput).Min      = -25;
    opspec.Inputs(ids.u.YawInput).Max      = +25;

    opspec.Inputs(ids.u.ThrottleInput).Known    = false;
    opspec.Inputs(ids.u.ThrottleInput).u        = 0;
    opspec.Inputs(ids.u.ThrottleInput).Min      = 0;
    opspec.Inputs(ids.u.ThrottleInput).Max      = +1;


    out = opspec;
end

function out = subV2S(vararg)
    % convert varargin to struct
    for iter = 1:2:numel(vararg)
        out.(vararg{iter}) = vararg{iter + 1};
    end
end

