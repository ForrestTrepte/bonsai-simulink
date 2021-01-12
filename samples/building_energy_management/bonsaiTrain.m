% Copyright (c) Microsoft Corporation.
% Licensed under the MIT License.

% Main entrypoint for training a Bonsai brain. After starting this script you
% must begin training your brain in the web, selecting the "Simulink Cartpole"
% simulator.

% Load startupFiles 
% DEFAULT_SIMULATION_RATE = 0.25; % sec 
init_vars

% load model and enable fast restart
mdl = 'buildingEnergyManagement';
load_system(mdl);
set_param(mdl, 'FastRestart', 'on');

% run training
config = bonsaiConfig;
BonsaiRunTraining(config, mdl, @episodeStartCallback);

% callback for running model with provided episode configuration
function episodeStartCallback(mdl, episodeConfig)
    in = Simulink.SimulationInput(mdl);
    in = in.setVariable('initToutdoor', episodeConfig.input_Toutdoor);
    in = in.setVariable('n_rooms', episodeConfig.input_nRooms);
    in = in.setVariable('numWindows_room_1', episodeConfig.input_nWindowsRoom1);
    in = in.setVariable('numWindows_room_2', episodeConfig.input_nWindowsRoom2);
    in = in.setVariable('numWindows_room_3', episodeConfig.input_nWindowsRoom3);
    sim(in);
end
