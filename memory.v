module Memory(
    input wire clk;
    input wire [7:0] address,
    input wire [7:0] data_in,
    input wire write_enable,
    output reg [7:0] data_out
);

reg [7:0] mem_array [255:0];
    always @(posedge clk) begin
        if(write_enable) begin
            mem_array[address] <= data_out;
        end
        data_out <= mem_array[address];
    end
endModule
