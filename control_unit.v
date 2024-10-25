module ControlUnit(
    input wire [7:0] opcode,
    output reg ALUOp,
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    output reg Branch
);
    always @(*) begin
        // Default values
        ALUOp = 0;
        MemRead = 0;
        MemWrite = 0;
        RegWrite = 0;
        Branch = 0;

        case(opcode)
            8'b0000: begin // AND operation
                ALUOp = 1; // Control signal for ALU to perform AND
                RegWrite = 1; // Write result back to register
            end
            8'b0001: begin // OR operation
                ALUOp = 1; // Control signal for ALU to perform OR
                RegWrite = 1; // Write result back to register
            end
            8'b0010: begin // ADD operation
                ALUOp = 2; // Control signal for ALU to perform ADD
                RegWrite = 1; // Write result back to register
            end
            8'b0011: begin // SUB operation
                ALUOp = 2; // Control signal for ALU to perform SUB
                RegWrite = 1; // Write result back to register
            end
            8'b0100: begin // LOAD operation
                MemRead = 1; // Read data from memory
                RegWrite = 1; // Write data back to register
            end
            8'b0101: begin // STORE operation
                MemWrite = 1; // Write data to memory
            end
            8'b0110: begin // BRANCH operation
                Branch = 1; // Indicates a branch instruction
            end
            default: begin
            end
        endcase
    end
endmodule
