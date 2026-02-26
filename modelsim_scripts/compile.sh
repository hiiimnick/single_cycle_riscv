#!/bin/bash
# Compile all RTL and testbench files

VERILOG_DIR="../rtl"
SIM_DIR="../sim"

echo "Compiling RTL modules"
iverilog -I$VERILOG_DIR -o simulation \
    $VERILOG_DIR/defines.v \
    $VERILOG_DIR/alu.v \
    $VERILOG_DIR/reg.v \
    $VERILOG_DIR/decoder.v \
    $VERILOG_DIR/control.v \
    $VERILOG_DIR/riscv_simple.v \
    $SIM_DIR/testbenches/tb_riscv_integration.v

echo "Compilation complete."

read -p "Press Enter to continue"