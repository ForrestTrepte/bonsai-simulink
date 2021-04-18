% Copyright (c) Microsoft Corporation.
% Licensed under the MIT License.

% Simple simulation class that demonstrates reciving config and actions,
% reset, step, and returning state.

classdef Simulation < handle
    properties (Access = private)
        observation1;
        observation2;
        config_array3;
        sim_reward;
    end
        
    methods (Access = public)
        function reset(obj, config)
            obj.observation1 = zeros(10, 1);
            obj.observation2 = zeros(20, 1);
            obj.sim_reward = 0;
            obj.config_array3 = config.config_array3;
        end
        
        function halted = step(obj, action)
            obj.observation1 = action.action_array1 * 2;
            obj.observation2 = action.action_array2 * 3;
            obj.sim_reward = sum(obj.observation1) + sum(obj.observation2) + sum(obj.config_array3);
            halted = false;
        end
        
        function state = getState(obj)
            state = {obj.observation1 obj.observation2 obj.sim_reward};
        end
    end
end
