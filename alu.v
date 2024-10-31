module Alu(
    input wire [3:0] opcode,  // Adjusted to 4 bits
    input wire [7:0] A,
    input wire [7:0] B,
    output reg [7:0] Result,
    output reg Zero,
    output reg Carry,
    output reg Negative
);

always @(*) begin
    // Initialize outputs
    Result = 8'b0;
    Zero = 0;
    Carry = 0;
    Negative = 0;

    case(opcode)
        4'b0000: begin // AND
            Result = A & B;
        end
        4'b0001: begin // OR
            Result = A | B;
        end
        4'b0010: begin // ADD
            {Carry, Result} = A + B;  // Calculate result and carry
        end
        4'b0011: begin // SUB
            {Carry, Result} = {1'b0, A} - {1'b0, B}; // Ensure Carry reflects borrow
            Negative = Result[7]; // Set Negative flag based on the result
        end
        4'b0100: begin // XOR
            Result = A ^ B;
        end
        default: begin
            Result = 8'b0;
        end
    endcase

    Zero = (Result == 8'b0); // Check if result is zero
    Negative = Result[7]; // Check if result is negative

    // Optional: Uncomment below if you want to see debug output
    // $display("ALU Opcode: %b, A: %b, B: %b, Result: %b, Zero: %b, Carry: %b, Negative: %b", opcode, A, B, Result, Zero, Carry, Negative);
end

endmodule
