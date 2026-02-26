echo "Running compile.do"
do compile.do

echo "Starting simulation"
vsim work.tb_riscv

# add only the selected tb_riscv signals to the wave window
add wave /tb_riscv/clk
add wave /tb_riscv/rst_n
add wave /tb_riscv/instr
add wave /tb_riscv/result
add wave /tb_riscv/branch_taken
add wave /tb_riscv/passed
add wave /tb_riscv/total

echo "Running simulation"
run -all

echo "Simulation finished."
quit