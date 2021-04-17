% Copyright (c) Microsoft Corporation.
% Licensed under the MIT License.

% Main entrypoint for training a Bonsai brain. After starting this script you
% must begin training your brain in the web, selecting the "Simulink Cartpole"
% simulator.

% load model and enable fast restart
mdl = 'cartpole_discrete';
load_system(mdl);
set_param(mdl, 'FastRestart', 'on');

% run training
config = bonsaiConfig;
MatlabBonsaiRunTraining(config, mdl, @episodeStartCallback);

% callback for running model with provided episode configuration
function episodeStartCallback(mdl, episodeConfig)
    global session
    in = Simulink.SimulationInput(mdl);
    in = in.setVariable('initialPos', episodeConfig.pos);
    %sim(in);
    %logger = bonsai.Logger('Session', false);
    %logger.log(sprintf('Have session: %', session.lastEvent])
    %state = containers.Map(obj.config.stateSchema, state);
    fprintf('Starting MATLAB Episode\n');
    session.getNextEvent(0, [0.11 0.12 0.13 0.14], false);
    disp(session.lastEvent)
    if session.lastEvent == bonsai.EventTypes.EpisodeStep
        disp(session.lastAction)
    end
    session.getNextEvent(0, [0.21 0.22 0.23 0.24], false);
    disp(session.lastEvent)
    if session.lastEvent == bonsai.EventTypes.EpisodeStep
        disp(session.lastAction)
    end
    session.getNextEvent(0, [10 20 30 40], false);
    disp(session.lastEvent)
    if session.lastEvent == bonsai.EventTypes.EpisodeStep
        disp(session.lastAction)
    end
end
