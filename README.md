# Single Cycle RISC-V Processor

## Overview

This project implements a simplified single-cycle RISC-V processor in Verilog. The processor executes basic RISC-V instructions in a single clock cycle, making it suitable for educational purposes and understanding fundamental processor design concepts.

## Architecture

The processor consists of three main components:

### 1. ALU (Arithmetic Logic Unit)
Located in [alu.v](alu.v), the ALU performs arithmetic and logical operations on two 32-bit operands based on a 4-bit opcode. Supported operations include:
- Arithmetic: ADD, SUB
- Logical: AND, OR, XOR, NOR
- Comparison: SLT (Set Less Than)
- Shifts: SLL (Shift Left Logical), SRL (Shift Right Logical)

### 2. Register File
Implemented in [reg.v](reg.v), the register file contains 32 registers of 32 bits each. It supports:
- Simultaneous reading from two registers
- Single write operation per clock cycle
- Register x0 is hardwired to zero (RISC-V convention)
- Synchronous writes and asynchronous reads

### 3. Main Processor
The [riscv_simple.v](riscv_simple.v) module integrates the ALU and register file, handling instruction decoding and control signals. Currently supported instructions:
- **ADDI**: Add Immediate (I-type)
- **ADD**: Add Register (R-type)
- **BEQ**: Branch if Equal (B-type)

## Instruction Format

### R-Type (Register-Register)
```
[funct7: 7 bits] [rs2: 5 bits] [rs1: 5 bits] [funct3: 3 bits] [rd: 5 bits] [opcode: 7 bits]
```

### I-Type (Immediate)
```
[immediate: 12 bits] [rs1: 5 bits] [funct3: 3 bits] [rd: 5 bits] [opcode: 7 bits]
```

### B-Type (Branch)
```
[imm[12|10:5]: 7 bits] [rs2: 5 bits] [rs1: 5 bits] [funct3: 3 bits] [imm[4:1|11]: 5 bits] [opcode: 7 bits]
```

## Testing

The testbench [tb_riscv.v](tb_riscv.v) verifies the core functionality:
- ADDI instruction execution
- ADD instruction with register-to-register operations
- BEQ branch logic (both taken and not taken conditions)

Run the testbench using a Verilog simulator (ModelSim, Vivado, etc.).

## Signal Description

### Clock and Reset
- `clk`: System clock
- `rst_n`: Active-low reset signal

### Instruction Input
- `instr[31:0]`: 32-bit instruction

### Output Signals
- `aluresult[31:0]`: ALU computation result
- `branch_taken`: Branch taken flag (1 if branch condition is met, 0 otherwise)

## Design Decisions

1. **Single Cycle**: All instructions complete in one clock cycle, simplifying control logic but limiting scalability.
2. **Synchronous Writes**: Register writes occur on clock edges, maintaining data consistency.
3. **Asynchronous Reads**: Register reads are combinational, reducing latency for instruction decoding.
4. **Sign Extension**: Immediate values are sign-extended to 32 bits for I-type instructions.

## Limitations

- No data memory (load/store instructions not implemented)
- No instruction memory abstraction
- Limited instruction set
- No pipeline stages (execution latency for dependent instructions)
- No exception handling

## Future Work

See ROADMAP.md for planned enhancements.