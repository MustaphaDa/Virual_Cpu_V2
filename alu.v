module Alu(
    input wire [7:0] opcode, // Corrected to [7:0]
    input wire [7:0] A, B,
    output reg [7:0] Result,
    output reg Zero, Carry, Negative // Capitalized 'Zero' to match usage
);
    always @(*) begin   
        Result = 8'b0; // Corrected variable name from 'result' to 'Result'
        Zero = 0;
        Carry = 0;
        Negative = 0;
        case(opcode)
            8'b0000: Result = A & B;        // Bitwise AND
            8'b0001: Result = A | B;        // Bitwise OR
            8'b0010: {Carry, Result} = A + B; // Addition with Carry
            8'b0011: {Carry, Result} = A - B; // Subtraction with Borrow
            8'b0100: Result = A ^ B;        // Bitwise XOR
            8'b0101: Result = A << 1;       // Shift left
            8'b0110: Result = A >> 1;       // Shift right
            8'b0111: Result = A | B;        // Duplicate case - you might want to remove this
            default: Result = 8'b0;         // Default case corrected to include a colon
        endcase
        
        Zero = (Result == 8'b0);           // Set Zero flag if Result is zero
        Negative = Result[7];               // Set Negative flag if Result is negative (for signed numbers)
    end
endmodule
