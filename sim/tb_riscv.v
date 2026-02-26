//------------------------------------------------------------------------------
// Project     : Single Cycle RISC-V Processor
// Module      : tb_riscv.v
// Author      : Cristian-Nicolae Carcaleteanu
// Date        : Dec. 10, 2025
//------------------------------------------------------------------------------

`timescale 1ns / 1ps
`include "../rtl/defines.v"

module tb_riscv;

    reg clk;
    reg rst_n;
    reg [31:0] instr;
    wire [31:0] result;
    wire branch_taken;

    integer passed = 0;
    integer total = 0;

    // Machine code for instructions
    localparam [31:0] ADDI_X1_X0_5  = 32'h00500093; // addi x1, x0, 5  ; x1 = 5
    localparam [31:0] ADDI_X2_X0_10 = 32'h00A00113; // addi x2, x0, 10 ; x2 = 10
    localparam [31:0] ADDI_X2_X0_5  = 32'h00500113; // addi x2, x0, 5  ; x2 = 5
    localparam [31:0] ADD_X3_X1_X2  = 32'h002081B3; // add x3, x1, x2  ; x3 = 15
    localparam [31:0] BEQ_X1_X2     = 32'h00208063; // beq x1, x2, 0   ; branch if equal

    riscv_simple uut (
        .clk(clk),
        .rst_n(rst_n),
        .instr(instr),
        .aluresult(result),
        .branch_taken(branch_taken)
    );

    always #5 clk = ~clk; // Clock generation (10ns period)

    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        instr = 32'd0;

        #10;
        rst_n = 1'b1;

        // Test 1: ADDI x1, x0, 5
        $display("[%0t] Test 1: ADDI x1, x0, 5", $time);
        instr = ADDI_X1_X0_5;
        #10;
        $display("  x1 should be 5");

        // Test 2: ADDI x2, x0, 10
        $display("[%0t] Test 2: ADDI x2, x0, 10", $time);
        instr = ADDI_X2_X0_10;
        #10;
        $display("  x2 should be 10");

        // Test 3: ADD x3, x1, x2 (5 + 10 = 15)
        $display("[%0t] Test 3: ADD x3, x1, x2", $time);
        instr = ADD_X3_X1_X2;
        #10;
        $display("  Expected result: 15, obtained: %0d", result);

        if (result == 15) begin
            $display("  Status: PASSED");
            passed = passed + 1;
        end else begin
            $display("  Status: FAILED");
        end
        total = total + 1;

        // Test 4: BEQ x1(5), x2(10) - should NOT branch
        $display("[%0t] Test 4: BEQ x1(5), x2(10) - expect no branch", $time);
        instr = BEQ_X1_X2;
        #10;
        $display("  branch_taken = %0d", branch_taken);

        if (branch_taken == 0) begin
            $display("  Status: PASSED");
            passed = passed + 1;
        end else begin
            $display("  Status: FAILED");
        end
        total = total + 1;

        // Test 5: Make x2 = 5 (same as x1)
        $display("[%0t] Test 5: ADDI x2, x0, 5", $time);
        instr = ADDI_X2_X0_5;
        #10;
        $display("  x2 should be 5");

        // Test 6: BEQ x1(5), x2(5) - should branch
        $display("[%0t] Test 6: BEQ x1(5), x2(5) - expect branch", $time);
        instr = BEQ_X1_X2;
        #10;
        $display("  branch_taken = %0d", branch_taken);

        if (branch_taken == 1) begin
            $display("  Status: PASSED");
            passed = passed + 1;
        end else begin
            $display("  Status: FAILED");
        end
        total = total + 1;

        // Summary
        $display("");
        $display("========================================");
        $display("Test Results: %0d/%0d PASSED", passed, total);
        $display("========================================");

        #10;
        $stop;

    end

endmodule