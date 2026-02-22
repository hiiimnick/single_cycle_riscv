//------------------------------------------------------------------------------
// Project     : Single Cycle RISC-V Processor
// Module      : tb_riscv_integration.v
// Author      : Cristian-Nicolae Carcaleteanu
// Date        : Jan. 19, 2026
//------------------------------------------------------------------------------

`include "../../rtl/defines.v"

module tb_riscv_integration;

    reg clk;
    reg rst_n;
    reg [31:0] instr;
    wire [31:0] aluresult;
    wire branch_taken;

    riscv_simple dut (
        .clk(clk),
        .rst_n(rst_n),
        .instr(instr),
        .aluresult(aluresult),
        .branch_taken(branch_taken)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        instr = 32'b0;
        
        #10 rst_n = 1;
        
        // Test ADDI x1, x0, 5
        instr = {12'd5, 5'b00000, 3'b000, 5'b00001, `OPCODE_ADDI};
        #10;
        
        // Test ADD x2, x1, x1
        instr = {7'b0000000, 5'b00001, 5'b00001, 3'b000, 5'b00010, `OPCODE_ADD};
        #10;
        
        // Test BEQ x1, x1, 0
        instr = {7'b0000000, 5'b00001, 5'b00001, 3'b000, 5'b00000, `OPCODE_BEQ};
        #10;
        
        $finish;
    end

endmodule