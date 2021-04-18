% Copyright (c) Microsoft Corporation.
% Licensed under the MIT License.

% Simple simulation class that demonstrates reciving config and actions,
% reset, step, and returning state.

classdef Simulation < handle
    properties (Access = private)
        x = 0;
        observationsA = [1 2 3];
        observationsB = [10 20 30 40 50];
    end
        
    methods (Access = public)
        function reset(obj, config)
            obj.x = config.initial_x;
            obj.observationsA = config.initial_observationsA
            obj.observationsB = config.initial_observationsB
        end
        
        function halted = step(obj, action)
            obj.x = obj.x + action.dx;
            obj.observationsA = obj.observationsA + action.actionsA
            obj.observationsB = obj.observationsB + action.actionsB
            halted = false;
        end
        
        function state = getState(obj)
            state = {obj.x obj.observationsA obj.observationsB};
        end
    end
end
