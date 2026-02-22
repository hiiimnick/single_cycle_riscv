//------------------------------------------------------------------------------
// Project     : Single Cycle RISC-V Processor
// Module      : control.v
// Author      : Cristian-Nicolae Carcaleteanu
// Date        : Jan. 19, 2026
//------------------------------------------------------------------------------

`include "defines.v"

module control_unit (
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output wire [3:0] alu_op,
    output wire use_immediate,
    output wire write_enable,
    output wire branch_en
);

    reg [3:0] alu_op_reg;
    reg use_immediate_reg;
    reg write_enable_reg;
    reg branch_en_reg;

    always @(*) begin
        alu_op_reg = `ALU_ADD;
        use_immediate_reg = 1'b0;
        write_enable_reg = 1'b0;
        branch_en_reg = 1'b0;

        case (opcode)
            `OPCODE_ADDI: begin
                alu_op_reg = `ALU_ADD;
                use_immediate_reg = 1'b1;
                write_enable_reg = 1'b1;
            end
            `OPCODE_ADD: begin
                alu_op_reg = (funct7 == 7'b0000000) ? `ALU_ADD : `ALU_SUB;
                use_immediate_reg = 1'b0;
                write_enable_reg = 1'b1;
            end
            `OPCODE_BEQ: begin
                alu_op_reg = `ALU_SUB;
                use_immediate_reg = 1'b0;
                write_enable_reg = 1'b0;
                branch_en_reg = 1'b1;
            end
        endcase
    end

    assign alu_op = alu_op_reg;
    assign use_immediate = use_immediate_reg;
    assign write_enable = write_enable_reg;
    assign branch_en = branch_en_reg;

endmodule