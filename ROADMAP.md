# Development Roadmap

## Phase 1: Memory Subsystem
- [ ] Implement instruction cache with configurable size
- [ ] Add data memory module for load/store operations
- [ ] Support LW (Load Word) and SW (Store Word) instructions
- [ ] Implement memory address translation and alignment checks

## Phase 2: Extended Instruction Set
- [ ] Add all remaining R-type arithmetic operations (MUL, DIV, REM)
- [ ] Implement shift operations with variable amounts
- [ ] Add logical right shift (SRL) and arithmetic right shift (SRA)
- [ ] Support additional I-type instructions (ANDI, ORI, XORI)
- [ ] Implement J-type branch instructions (JAL, JALR)
- [ ] Add unconditional branch support (BNE, BLT, BGE, etc.)

## Phase 3: Pipeline Architecture
- [ ] Introduce 5-stage pipeline (Fetch, Decode, Execute, Memory, Writeback)
- [ ] Implement hazard detection and forwarding logic
- [ ] Add stall generation for data dependencies
- [ ] Support branch prediction to reduce pipeline flushes

## Phase 4: Control and Exceptions
- [ ] Add interrupt handling capability
- [ ] Implement exception detection (illegal instructions, overflow)
- [ ] Create system control registers (CSR) for processor state
- [ ] Support supervisor and user privilege levels

## Phase 5: Performance Optimization
- [ ] Cache coherency for multi-core extensions
- [ ] Branch target buffer for improved prediction
- [ ] Instruction prefetching mechanisms
- [ ] Out-of-order execution support

## Phase 6: Testing and Validation
- [ ] Expand testbench with edge case coverage
- [ ] Add formal verification properties
- [ ] Create compliance tests for RISC-V ISA
- [ ] Performance benchmarking suite

## Phase 7: Synthesis and FPGA Deployment
- [ ] Design constraints for timing closure
- [ ] FPGA implementation on Xilinx/Altera platforms
- [ ] Power analysis and optimization
- [ ] Documentation for hardware implementation

## Known Issues
- Register write-back happens in the same cycle as execution, may cause timing issues
- No support for immediate forwarding in pipeline stage
- Branch resolution requires one extra cycle for register reads

## Contributors
- Cristian-Nicolae Carcaleteanu