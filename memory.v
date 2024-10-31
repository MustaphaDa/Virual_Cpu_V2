module memory (
    input wire clk,
    input wire MemRead,
    input wire MemWrite,
    input wire [7:0] address,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

reg [7:0] mem [0:255];  // 256 bytes of memory

initial begin
    // Initialize memory with zeros
    mem[0] = 8'h00;
    mem[1] = 8'h00;
    mem[2] = 8'h00;
    // ... and so on for other addresses you need
    data_out = 8'h00;
end

always @(posedge clk) begin
    if (MemWrite) begin
        mem[address] <= data_in;
    end
    if (MemRead) begin
        data_out <= mem[address];
    end
end

endmodule