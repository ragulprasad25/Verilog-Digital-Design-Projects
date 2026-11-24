# Traffic Light Controller Using Verilog

A four-state Finite State Machine (FSM) traffic light controller for a North-South (NS) and East-West (EW) road intersection.

## Traffic-light states

| State | North-South | East-West |
|---|---|---|
| State 0 | Green | Red |
| State 1 | Yellow | Red |
| State 2 | Red | Green |
| State 3 | Red | Yellow |

The controller repeats the sequence: State 0 -> State 1 -> State 2 -> State 3 -> State 0.

Light encoding:
- `00` = Red
- `01` = Yellow
- `10` = Green

## Project structure

```text
Traffic-Light-Controller-Verilog/
├── src/
│   └── traffic_light_controller.v
├── sim/
│   └── tb_traffic_light.v
├── docs/
│   └── PROJECT_NOTES.md
├── .gitignore
└── README.md
```

## Tools
- Visual Studio Code
- Icarus Verilog (`iverilog` and `vvp`)
- GTKWave
- Yosys (optional synthesis)

## Compile and run (PowerShell)

Open a terminal in the project root and run:

```powershell
$env:Path += ";C:\iverilog\bin"
iverilog -g2012 -o sim/traffic_light_sim src/traffic_light_controller.v sim/tb_traffic_light.v
vvp sim/traffic_light_sim
```

The testbench checks the reset state, all four traffic-light states, and the return to the first state. It creates `traffic_light.vcd` in the project root.

## View the waveform

```bash
gtkwave traffic_light.vcd
```

Add these signals in GTKWave:
- `clk`
- `reset`
- `uut.state`
- `NS_light[1:0]`
- `EW_light[1:0]`

## Optional synthesis with Yosys

```bash
yosys -p "read_verilog src/traffic_light_controller.v; hierarchy -top traffic_light_controller; proc; opt; stat"
```

## Scope
This is the clock-driven FSM described in the project brief. It advances one state on each rising clock edge; it does not include real-world green/yellow timing counters, pedestrian inputs, vehicle sensors, or hardware pin constraints.
