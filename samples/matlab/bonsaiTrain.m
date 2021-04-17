% Copyright (c) Microsoft Corporation.
% Licensed under the MIT License.

% Main entrypoint for training a Bonsai brain. After starting this script you
% must begin training your brain in the web, selecting the "Simulink Cartpole"
% simulator.

% run training
config = bonsaiConfig;
BonsaiRunTraining(config, 'No Simulink Model', @episodeStartCallback);

function state = getState(iteration)
    varCount = 4;
    state = zeros(1, varCount);
    for i=1:varCount
        state(i) = iteration * 0.1 + i * 0.01;
    end
end

% callback for running model with provided episode configuration
function episodeStartCallback(mdl, episodeConfig)
    session = bonsai.Session.getInstance();
    logger = bonsai.Logger('BonsaiBlock', session.config.verbose);
    
    logger.log('Starting MATLAB Episode\n');
    disp(session.config.stateSchema);
    logger.log(sprintf('config.pos = %0.3g', episodeConfig.pos));
    
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
