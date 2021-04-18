# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

inkling "2.0"

using Math

# thresholds
const max_x = 10

type SimState {
    x: number,
}

type Action {
    dx: number<-2.0 .. 2.0>
}

type CartPoleConfig {
    initial_x: number
}

function Reward(obs: SimState) {
    return -Math.Abs(obs.x)
}

function Terminal(obs: SimState) {
    return Math.Abs(obs.x) > max_x
}

simulator CartpoleSimulator(action: Action, config: CartPoleConfig): SimState {
    #package "matlab3-nopass"
}

graph (input: SimState): Action {
    concept balance(input): Action {
        curriculum {
            source CartpoleSimulator
            reward Reward
            terminal Terminal
            training {
                EpisodeIterationLimit: 10,
                NoProgressIterationLimit: 100000
            }
            lesson balancing {
                scenario {
                    initial_x: number<-5 .. 5>
                }
            }
        }
    }
    output balance
}
