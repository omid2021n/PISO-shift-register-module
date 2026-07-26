# PISO-shift-register-module
SystemVerilog_PISO_Shift_Register
# PISO Shift Register

## Description
An 8-bit Parallel-In Serial-Out (PISO) shift register written in SystemVerilog.

The module:
- Loads 8-bit parallel data
- Shifts data out serially (LSB first)
- Uses active-low asynchronous reset
- Provides a `done` signal after all bits are shifted

## Interface

| Signal | Direction | Description |
|--------|-----------|-------------|
| clk | input | Clock |
| rst_n | input | Active-low asynchronous reset |
| load | input | Load parallel data |
| en | input | Enable shifting |
| din[7:0] | input | Parallel input data |
| dout | output | Serial output |
| done | output | Shift complete flag |

## Operation

1. Assert `load` to load input data.
2. Enable shifting using `en`.
3. Data is shifted out from LSB first.
4. `done` becomes high after 8 clock cycles.
