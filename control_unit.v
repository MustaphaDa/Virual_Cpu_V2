module ControlUnit(
    input wire [7:0] opcode,
    output reg [7:0] ALUOp,
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    output reg Branch
);

always @(*) begin
    // Default values
    ALUOp = 8'b0;
    MemRead = 0;
    MemWrite = 0;
    RegWrite = 0;
    Branch = 0;

    case(opcode)
        8'b0000: begin // AND operation
            ALUOp = 8'b0000;  // Match ALU opcode
            RegWrite = 1;
            $display("Control Unit: AND operation");
        end
        8'b0001: begin // OR operation
            ALUOp = 8'b0001;  // Match ALU opcode
            RegWrite = 1;
            $display("Control Unit: OR operation");
        end
        8'b0010: begin // ADD operation
            ALUOp = 8'b0010;  // Match ALU opcode
            RegWrite = 1;
            $display("Control Unit: ADD operation");
        end
        8'b0011: begin // SUB operation
            ALUOp = 8'b0011;  // Match ALU opcode
            RegWrite = 1;
            $display("Control Unit: SUB operation");
        end
        8'b0100: begin // XOR operation
            ALUOp = 8'b0100;  // Match ALU opcode
            RegWrite = 1;
            $display("Control Unit: XOR operation");
        end
        default: begin
            ALUOp = 8'b0000;
            $display("Control Unit: Invalid operation");
        end
    endcase
end
endmodule