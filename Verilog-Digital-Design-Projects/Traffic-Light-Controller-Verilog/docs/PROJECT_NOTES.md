# Traffic Light Controller — Project Notes

## Objective
Design, simulate, and synthesize a traffic light controller using a Finite State Machine (FSM).

## FSM sequence
1. State 0: North-South Green, East-West Red
2. State 1: North-South Yellow, East-West Red
3. State 2: North-South Red, East-West Green
4. State 3: North-South Red, East-West Yellow
5. Return to State 0 and repeat.

## Inputs and outputs
- `clk`: clock input
- `reset`: active-high asynchronous reset
- `NS_light[1:0]`: North-South signal
- `EW_light[1:0]`: East-West signal

Light encoding:
- `00`: Red
- `01`: Yellow
- `10`: Green

## Design structure
- `src/traffic_light_controller.v`: state register, next-state logic, and output logic.
- `sim/tb_traffic_light.v`: clock generation, reset sequence, output checks, and VCD generation.

## Simulation tools
Icarus Verilog compiles and runs the Verilog testbench. GTKWave displays `traffic_light.vcd`. Yosys can synthesize the controller and report the inferred hardware.

## Scope note
The uploaded project brief advances the FSM on each clock cycle. This implementation follows that specification. It does not add programmable traffic-light durations or vehicle/pedestrian sensors.
