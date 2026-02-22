//------------------------------------------------------------------------------
// Project     : Single Cycle RISC-V Processor
// Module      : alu.v
// Author      : Cristian-Nicolae Carcaleteanu
// Date        : Dec. 10, 2025
//------------------------------------------------------------------------------

`include "defines.v"

module alu (
    input wire [31:0] operand_a,
    input wire [31:0] operand_b,
    input wire [3:0] alu_op,
    output wire [31:0] result,
    output wire zero
);

    wire [31:0] sum_diff;
    wire [31:0] logical_result;
    
    assign sum_diff = (alu_op == `ALU_ADD) ? (operand_a + operand_b) : 
                      (alu_op == `ALU_SUB) ? (operand_a - operand_b) : 32'b0;  // either ADD or SUB
    
    assign logical_result = (alu_op == `ALU_AND) ? (operand_a & operand_b) :
                            (alu_op == `ALU_OR)  ? (operand_a | operand_b) :
                            (alu_op == `ALU_XOR) ? (operand_a ^ operand_b) :
                            (alu_op == `ALU_NOR) ? ~(operand_a | operand_b) :
                            (alu_op == `ALU_SLL) ? (operand_a << operand_b[4:0]) :
                            (alu_op == `ALU_SRL) ? (operand_a >> operand_b[4:0]) : 32'b0;
    
    assign result = (alu_op == `ALU_ADD || alu_op == `ALU_SUB) ? sum_diff : 
                    (alu_op == `ALU_SLT) ? {{31{1'b0}}, (operand_a < operand_b)} :  
                    logical_result;
    
    assign zero = (result == 32'b0) ? 1'b1 : 1'b0; // BEQ condition

endmodule