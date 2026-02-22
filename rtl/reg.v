//------------------------------------------------------------------------------
// Project     : Single Cycle RISC-V Processor
// Module      : reg.v
// Author      : Cristian-Nicolae Carcaleteanu
// Date        : Dec. 10, 2025
//------------------------------------------------------------------------------

`include "defines.v"

module register_file (
    input wire clk,                 // clock
    input wire rst_n,               // active low reset
    input wire [4:0] rs1,           // source register 1
    input wire [4:0] rs2,           // source register 2
    input wire [4:0] rd,            // destination register
    input wire [31:0] write_data,   // data to write
    input wire write_enable,        // write enable signal
    output wire [31:0] read_data1,  // data read from source register 1
    output wire [31:0] read_data2   // data read from source register 2
);

    reg [31:0] registers [`REGFILE_SIZE - 1:0]; // register array (32 registers of 32 bits each)
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            for (i = 0; i < `REGFILE_SIZE; i = i + 1) begin
                registers[i] <= 32'b0; // reset all registers to 0
            end
        end else if (write_enable && rd != `REG_ZERO) begin
            registers[rd] <= write_data; // write data to destination register
        end
    end

    assign read_data1 = (rs1 == `REG_ZERO) ? 32'b0 : registers[rs1]; // read data from source register 1
    assign read_data2 = (rs2 == `REG_ZERO) ? 32'b0 : registers[rs2]; // read data from source register 2

endmodule