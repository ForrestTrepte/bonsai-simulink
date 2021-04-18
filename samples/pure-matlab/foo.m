function [reward, observation1, observation2] = foo(action_array1, action_array2,config_array3)
% array 1 is an action of length 10
% array 2 is an action of length 20 
observation1 = action_array1*2;
observation2 = action_array2*3;
reward = sum(observation1) + sum(observation2) + sum(config_array3)

