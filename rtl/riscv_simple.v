//------------------------------------------------------------------------------
// Project     : Single Cycle RISC-V Processor
// Module      : riscv_simple.v
// Author      : Cristian-Nicolae Carcaleteanu
// Date        : Jan. 19, 2026
//------------------------------------------------------------------------------

`include "defines.v"

module riscv_simple (
    input wire clk,
    input wire rst_n,
    input wire [31:0] instr,
    output wire [31:0] aluresult,
    output wire branch_taken
);

    // Decoder outputs
    wire [6:0] opcode;
    wire [4:0] rd, rs1, rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [31:0] immediate;

    // Control outputs
    wire [3:0] alu_op;
    wire use_immediate;
    wire write_enable;
    wire branch_en;

    // Register file outputs
    wire [31:0] read_data1, read_data2;

    // ALU outputs
    wire [31:0] alu_result;
    wire zero_flag;

    // Instruction decoder
    decoder decoder_inst (
        .instr(instr),
        .opcode(opcode),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .funct3(funct3),
        .funct7(funct7),
        .immediate(immediate)
    );

    // Control unit
    control_unit control_inst (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_op(alu_op),
        .use_immediate(use_immediate),
        .write_enable(write_enable),
        .branch_en(branch_en)
    );

    // Register file
    register_file regfile_inst (
        .clk(clk),
        .rst_n(rst_n),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(alu_result),
        .write_enable(write_enable),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ALU
    alu alu_inst (
        .operand_a(read_data1),
        .operand_b(use_immediate ? immediate : read_data2),
        .alu_op(alu_op),
        .result(alu_result),
        .zero(zero_flag)
    );

    // Branch logic
    assign branch_taken = branch_en & zero_flag;
    assign aluresult = alu_result;

endmodule