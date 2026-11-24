# Project Notes

## What is an ALU?

An Arithmetic Logic Unit is a digital circuit that performs arithmetic and logical operations. This project builds a small 8-bit ALU using Verilog.

## Inputs

- `A[7:0]`: first 8-bit operand
- `B[7:0]`: second 8-bit operand
- `Sel[2:0]`: operation selector

## Outputs

- `Result[7:0]`: 8-bit operation result
- `CarryOut`: ninth bit of the arithmetic result
- `Zero`: high (`1`) when `Result` is zero

## Selector table

| Sel | Operation |
|---|---|
| 000 | Addition |
| 001 | Subtraction |
| 010 | AND |
| 011 | OR |
| 100 | XOR |

## Testbench

The testbench applies input values to the ALU and checks the outputs against expected values. It also writes a VCD waveform file named `alu.vcd`, which can be opened in GTKWave.

## Simulation flow

1. Compile the design and testbench with Icarus Verilog.
2. Run the compiled simulation.
3. Check the PASS/FAIL output.
4. Optionally inspect `alu.vcd` in GTKWave.
