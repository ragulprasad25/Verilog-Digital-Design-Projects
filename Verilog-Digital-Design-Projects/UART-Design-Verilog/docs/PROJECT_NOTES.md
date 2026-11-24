# UART Project Notes

## UART frame format: 8-N-1
1. Start bit: logic 0
2. Eight data bits: least-significant bit first
3. No parity bit
4. One stop bit: logic 1

## Modules
- `uart_tx.v`: accepts a byte when `tx_start` is asserted while idle, then sends it serially. `tx_busy` is high during transmission.
- `uart_rx.v`: detects the start bit, samples eight data bits, checks the stop bit, and pulses `rx_done` when a byte is received.
- `uart_tb.v`: connects TX to RX for loopback testing and verifies four bytes.

## Clock divider
`CLKS_PER_BIT` is the number of clock cycles per serial bit. For a 50 MHz clock and 9600 baud, use approximately 5208. The testbench uses 16 only to shorten simulation time.

## Verification bytes
- `A5`: mixed bit pattern
- `3C`: mixed bit pattern
- `00`: all-zero pattern
- `FF`: all-one pattern

## Note
Loopback simulation verifies the RTL modules together in simulation; it does not by itself prove operation on a physical FPGA board.
