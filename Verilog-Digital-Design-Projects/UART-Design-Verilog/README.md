# UART Design and Simulation using Verilog

A UART (Universal Asynchronous Receiver-Transmitter) implemented in Verilog HDL. This project contains a transmitter (TX), receiver (RX), and a loopback testbench.

## Features
- 8-bit data, one start bit, one stop bit, no parity (8-N-1)
- Least-significant bit (LSB) transmitted first
- Parameterized baud-rate clock divider
- TX-to-RX loopback verification
- VCD waveform generation for GTKWave

## Folder structure
```text
UART-Design-Verilog/
├── src/
│   ├── uart_tx.v
│   └── uart_rx.v
├── sim/
│   └── uart_tb.v
├── docs/
│   └── PROJECT_NOTES.md
├── .gitignore
└── README.md
```

## Tools
- Visual Studio Code
- Icarus Verilog (`iverilog`, `vvp`)
- GTKWave
- Yosys (optional synthesis)

## Compile and run
Run these commands from the project root:

```bash
iverilog -g2012 -o sim/uart_sim src/uart_tx.v src/uart_rx.v sim/uart_tb.v
vvp sim/uart_sim
```

The testbench sends `A5`, `3C`, `00`, and `FF`, checks the received bytes, and prints a PASS/FAIL summary. It also creates `uart.vcd` in the project root.

## Open the waveform
```bash
gtkwave uart.vcd
```
Add `clk`, `rst`, `tx_start`, `tx_data[7:0]`, `tx`, `tx_busy`, `rx_data[7:0]`, and `rx_done` to the waveform view.

## Baud-rate divider
The RTL default is 5208 clock cycles per bit, approximately 9600 baud with a 50 MHz clock (`50,000,000 / 9,600 ≈ 5208`). The testbench overrides this parameter to 16 to make simulation faster. Use a divider appropriate for your actual clock and baud rate.

## Scope
Educational 8-N-1 UART loopback design. The RX input is not yet protected by a two-flop synchronizer and the design does not include parity or detailed framing-error reporting. FPGA hardware use requires appropriate pin constraints and board-specific validation.
