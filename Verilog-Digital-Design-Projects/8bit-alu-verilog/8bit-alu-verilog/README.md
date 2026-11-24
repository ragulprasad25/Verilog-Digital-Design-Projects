# 8-bit ALU Design (Verilog)

A beginner-friendly Verilog project implementing an 8-bit Arithmetic Logic Unit (ALU).

## Features

- Addition (`A + B`)
- Subtraction (`A - B`)
- Bitwise AND (`A & B`)
- Bitwise OR (`A | B`)
- Bitwise XOR (`A ^ B`)
- `CarryOut` flag for arithmetic operations
- `Zero` flag when the 8-bit result is zero

## Operation selector

| `Sel` | Operation |
|---|---|
| `000` | Addition |
| `001` | Subtraction |
| `010` | AND |
| `011` | OR |
| `100` | XOR |
| Other values | Result and CarryOut are set to zero |

## Project structure

```text
8bit-alu-verilog/
├── src/
│   └── alu.v
├── sim/
│   └── tb_alu.v
├── docs/
│   └── PROJECT_NOTES.md
├── .gitignore
└── README.md
```

## Requirements

Install:
- Icarus Verilog (`iverilog` and `vvp`)
- GTKWave (optional, for viewing waveforms)
- VS Code (recommended editor)

## Run the simulation

Open a terminal in the project root.

### 1. Compile

```bash
iverilog -g2012 -Wall -o sim/alu_tb src/alu.v sim/tb_alu.v
```

### 2. Run

```bash
vvp sim/alu_tb
```

The testbench prints PASS/FAIL messages and creates `alu.vcd`.

### 3. View waveforms (optional)

```bash
gtkwave alu.vcd
```

## Push this project to GitHub

Create an empty GitHub repository, then run these commands from this folder:

```bash
git init
git add .
git commit -m "Initial 8-bit ALU Verilog project"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/8bit-alu-verilog.git
git push -u origin main
```

Replace the remote URL with your own repository URL.

## Important note about CarryOut

The arithmetic operations use a 9-bit result `{CarryOut, Result}`. For addition, `CarryOut` is the ninth carry bit. For subtraction, the ninth bit follows unsigned 9-bit subtraction behavior; it is not a conventional standalone borrow flag. The supplied basic test uses a subtraction where `A` is greater than `B`, so `CarryOut` is zero.
