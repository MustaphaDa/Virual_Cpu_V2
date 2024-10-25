module Alu(
    input wire [7;0] opcode,
    input wire [7;0] A,B,
    output reg [7:0] result,
    output reg zero, Carry, Negative
);
    always @(*) begin   
        Zero = 0;
        Carry = 0;
        Negative = 0;
        result = 8'b0

        case(opcode)
            8'b0000: result = A & B;
            8'b0001: result = A | B;
            8'b0010: {Carry,result} = A + B;
            8'b0011: {Carry,result}  = A - B;
            8'b0100: result = A ^ B;
            8'b0101: result = A << 1;
            8'b0110: result = A >> 1;
            8'b0111: result = A | B;
            default result = 8'b0;
        endcase
        Zero = (result == 8'b0);
        Negative = result[7];
    end
endModule


