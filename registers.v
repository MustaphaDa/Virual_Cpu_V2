module Registers(
    input wire clk,                // Clock signal
    input wire [2:0] read_addr,    // 3-bit address for reading (up to 8 registers)
    input wire [2:0] write_addr,   // 3-bit address for writing
    input wire [7:0] data_in,      // Data to write
    input wire write_enable,        // Write enable signal
    output reg [7:0] data_out      // Data to read
);

    // Define a register array of 8 registers (8 bits each)
    reg [7:0] reg_array [7:0];

    always @(posedge clk) begin
        if (write_enable) begin
            reg_array[write_addr] <= data_in; // Write data to the specified register
        end
        data_out <= reg_array[read_addr]; // Read data from the specified register
    end

endmodule
