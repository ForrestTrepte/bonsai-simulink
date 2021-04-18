% Copyright (c) Microsoft Corporation.
% Licensed under the MIT License.

% Simulation class that 
% must begin training your brain in the web, selecting the "Simulink Cartpole"
% simulator.

classdef Simulation < handle
    properties (Access = private)
        x = 0;
    end
        
    methods (Access = public)
        function reset(obj, config)
            obj.x = config.initial_x;
        end
        
        function halted = step(obj, action)
            obj.x = obj.x + action.dx;
            halted = false;
        end
        
        function state = getState(obj)
            state = [obj.x];
        end
    end
end
