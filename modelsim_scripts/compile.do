if {[file exists work]} {
    vdel -all
}
vlib work

set rtl_path "../rtl"
set sim_path "../sim"

echo "Compiling RTL modules"
vlog -work work $rtl_path/defines.v
vlog -work work $rtl_path/alu.v
vlog -work work $rtl_path/reg.v
vlog -work work $rtl_path/decoder.v
vlog -work work $rtl_path/control.v
vlog -work work $rtl_path/riscv_simple.v

echo "Compiling testbenches"
vlog -work work $sim_path/testbenches/tb_riscv.v

echo "Compilation complete."