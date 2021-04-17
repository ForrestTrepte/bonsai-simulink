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

function state = getState(iteration)
    varCount = 4;
    state = zeros(1, varCount);
    for i=1:varCount
        state(i) = iteration * 0.1 + i * 0.01;
    end
end

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
    disp(session.config.stateSchema);
    disp(episodeConfig);
    iteration = 0;
    while true
        iteration = iteration + 1;
        session.getNextEvent(iteration, getState(iteration), false);
        if session.lastEvent ~= bonsai.EventTypes.EpisodeStep
            return
        end
        disp(session.lastAction)
    end
end
