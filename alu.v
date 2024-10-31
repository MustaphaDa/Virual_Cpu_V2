module Alu(
    input wire [7:0] opcode,
    input wire [7:0] A,
    input wire [7:0] B,
    output reg [7:0] Result,
    output reg Zero,
    output reg Carry,
    output reg Negative
);

always @(*) begin
    // Initialize outputs
    $display("ALU Opcode: %b", opcode);
    $display("A: %b, B: %b", A, B);
    
    Result = 8'b0;
    Zero = 0;
    Carry = 0;
    Negative = 0;

    case(opcode)
        8'b0000: begin // AND
            Result = A & B;
            $display("ALU: AND operation");
        end
        8'b0001: begin // OR
            Result = A | B;
            $display("ALU: OR operation");
        end
        8'b0010: begin // ADD
            {Carry, Result} = A + B;
            $display("ALU: ADD operation");
        end
        8'b0011: begin // SUB
            Result = A - B;
            Negative = Result[7];
            $display("ALU: SUB operation");
        end
        8'b0100: begin // XOR
            Result = A ^ B;
            $display("ALU: XOR operation");
        end
        default: begin
            Result = 8'b0;
            $display("ALU: Invalid operation");
        end
    endcase

    Zero = (Result == 8'b0);
    Negative = Result[7];
    
    $display("Result: %b, Zero: %b, Carry: %b, Negative: %b", Result, Zero, Carry, Negative);
end
endmodule