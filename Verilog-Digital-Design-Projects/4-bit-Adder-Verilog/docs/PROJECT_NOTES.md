# Project Notes — 4-bit Adder Using CMOS Logic

## Objective
Design, simulate, and lay out a 4-bit adder using CMOS logic.

## Verilog architecture
- `full_adder.v`: one-bit full adder.
- `four_bit_adder.v`: four full adders connected in a ripple-carry chain.
- `tb_four_bit_adder.v`: testbench with five checks and VCD waveform output.

## Full-adder equations
- Sum = A XOR B XOR Cin
- Cout = (A AND B) OR (B AND Cin) OR (A AND Cin)

## Ripple-carry connection
The carry output from each bit is connected to the carry input of the next bit:
FA0 -> FA1 -> FA2 -> FA3.

## Toolchain in the project brief
- Xschem: schematic editor
- Ngspice: SPICE simulation
- Magic: layout tool
- Netgen: layout-versus-schematic (LVS) checking
- Open_PDKs + Sky130: open-source CMOS process design kit

The transistor-level CMOS schematic and physical layout are not included in this initial Verilog project folder. They are follow-on implementation tasks.

## Arithmetic clarification
The supplied handout's Test Case 2 lists A=5, B=6, Cin=1 but gives Sum=8 and Cout=1. The arithmetic is 5 + 6 + 1 = 12, so the correct 4-bit output is Sum=1100 (hex C), Cout=0. The testbench uses the mathematically correct result.

The handout's Test Case 5 lists A=15, B=15, Cin=1 and expects Sum=1111 and Cout=1, which is correct (31 total).
