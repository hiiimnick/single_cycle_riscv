// Common definitions and parameters for RISC-V processor

// Opcodes
`define OPCODE_ADDI  7'b0010011
`define OPCODE_ADD   7'b0110011
`define OPCODE_BEQ   7'b1100011

// ALU Operations
`define ALU_ADD      4'b0000
`define ALU_SUB      4'b0001
`define ALU_AND      4'b0010
`define ALU_OR       4'b0011
`define ALU_XOR      4'b0100
`define ALU_NOR      4'b0101
`define ALU_SLT      4'b0110
`define ALU_SLL      4'b0111
`define ALU_SRL      4'b1000

// Instruction field positions
`define INSTR_OPCODE  6:0
`define INSTR_RD     11:7
`define INSTR_FUNCT3 14:12
`define INSTR_RS1    19:15
`define INSTR_RS2    24:20
`define INSTR_FUNCT7 31:25
`define INSTR_IMM_I  31:20
`define INSTR_IMM_B_1 31:25
`define INSTR_IMM_B_2 11:7

// Register definitions
`define REG_ZERO     5'b00000
`define REG_WIDTH    32
`define REGFILE_SIZE 32