# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

inkling "2.0"

using Math

# thresholds
const max_x = 10

type SimState {
    x: number,
    observationsA: number[3],
    observationsB: number[5],
}

type Action {
    dx: number<-2.0 .. 2.0>,
    actionsA: number<0, 1, 2>[3],
    actionsB: number<-1.0 .. 1.0>[5],
}

type Config {
    initial_x: number,
    initial_observationsA: number[3],
    initial_observationsB: number[5],
}

function Reward(obs: SimState) {
    return -Math.Abs(obs.x)
}

function Terminal(obs: SimState) {
    return Math.Abs(obs.x) > max_x
}

simulator PureMatlabSimulator(action: Action, config: Config): SimState {
    #package "pure-matlab3-passmodel"
}

graph (input: SimState): Action {
    concept balance(input): Action {
        curriculum {
            source PureMatlabSimulator
            reward Reward
            terminal Terminal
            training {
                EpisodeIterationLimit: 10,
                NoProgressIterationLimit: 100000
            }
            lesson balancing {
                scenario {
                    initial_x: number<-5 .. 5>,
                    initial_observationsA: number<0, 1, 2>[3],
                    initial_observationsB: number<-1.0 .. 1.0>[5],
                }
            }
        }
    }
    output balance
}
