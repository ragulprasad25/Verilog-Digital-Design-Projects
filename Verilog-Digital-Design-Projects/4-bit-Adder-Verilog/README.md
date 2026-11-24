# 4-bit Adder Using Verilog

A 4-bit ripple-carry adder designed by connecting four 1-bit full adders. The project includes Verilog RTL, a self-checking testbench, and waveform generation for GTKWave.

## Project structure

```text
4-bit-Adder-Verilog/
├── src/
│   ├── full_adder.v
│   └── four_bit_adder.v
├── sim/
│   └── tb_four_bit_adder.v
├── docs/
│   └── PROJECT_NOTES.md
├── .gitignore
└── README.md
```

## Requirements
- Visual Studio Code
- Icarus Verilog (`iverilog` and `vvp`)
- GTKWave
- For the CMOS schematic/layout portion: Xschem, Ngspice, Magic, Netgen, and Sky130 Open_PDKs (typically on Linux)

## Compile and simulate (PowerShell)

Run from the project root:

```powershell
$env:Path += ";C:\iverilog\bin"
iverilog -g2012 -o sim/adder_sim src/full_adder.v src/four_bit_adder.v sim/tb_four_bit_adder.v
vvp sim/adder_sim
```

The testbench checks five cases and creates `adder.vcd` in the project root.

## Expected test summary

```text
TEST SUMMARY: 5 PASS, 0 FAIL
```

## View the waveform

```bash
gtkwave adder.vcd
```

Add `A[3:0]`, `B[3:0]`, `Cin`, `Sum[3:0]`, and `Cout` to the waveform view.

## Test cases

| Test | A | B | Cin | Sum | Cout |
|---|---:|---:|---:|---:|---:|
| Basic addition | 1 | 3 | 0 | 4 | 0 |
| Addition with carry input | 5 | 6 | 1 | C | 0 |
| Carry propagation | F | F | 0 | E | 1 |
| Adding zero | 0 | 0 | 0 | 0 | 0 |
| Maximum values with carry input | F | F | 1 | F | 1 |

Values in the table are hexadecimal.

## CMOS design scope

The supplied project brief also asks for a transistor-level design and physical layout using Xschem, Ngspice, Magic, Netgen, and Sky130 Open_PDKs. This repository currently contains the Verilog implementation and simulation stage; the CMOS schematic, SPICE simulation, layout, DRC, and LVS stages are documented as follow-on work in `docs/PROJECT_NOTES.md`.
