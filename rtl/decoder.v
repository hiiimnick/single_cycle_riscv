//------------------------------------------------------------------------------
// Project     : Single Cycle RISC-V Processor
// Module      : decoder.v
// Author      : Cristian-Nicolae Carcaleteanu
// Date        : Jan. 19, 2026
//------------------------------------------------------------------------------

`include "defines.v"

module decoder (

    // decoder for RISC-V instructions, extracts fields and immediate values

    input wire [31:0] instr,
    output wire [6:0] opcode,
    output wire [4:0] rd,
    output wire [4:0] rs1,
    output wire [4:0] rs2,
    output wire [2:0] funct3,
    output wire [6:0] funct7,
    output wire [31:0] immediate
);

    assign opcode = instr[`INSTR_OPCODE];  // extract opcode, bits [6:0]
    assign rd = instr[`INSTR_RD];          // extract rd, bits [11:7]
    assign rs1 = instr[`INSTR_RS1];        // extract rs1, bits [19:15]
    assign rs2 = instr[`INSTR_RS2];        // extract rs2, bits [24:20]
    assign funct3 = instr[`INSTR_FUNCT3];  // extract funct3, bits [14:12]
    assign funct7 = instr[`INSTR_FUNCT7];  // extract funct7, bits [31:25]
    
    // Sign-extend immediate based on opcode
    wire [11:0] imm_12bit;
    assign imm_12bit = instr[`INSTR_IMM_I];
    assign immediate = {{20{imm_12bit[11]}}, imm_12bit};

endmodule