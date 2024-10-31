module ControlUnit(
    input wire [3:0] opcode,  // Changed to 4 bits based on CPU design
    output reg [7:0] ALUOp,
    output reg MemRead,
    output reg MemWrite,
    output reg RegWrite,
    output reg Branch,
    output reg Jump,
    output reg [7:0] address // Output for the memory address
);

always @(*) begin
    // Default values
    ALUOp = 8'b00000000;
    MemRead = 0;
    MemWrite = 0;
    RegWrite = 0;
    Branch = 0;
    Jump = 0;
    address = 8'b00000000; // Default address

    case (opcode)
        4'b0000: begin // AND operation
            ALUOp = 8'b00000000;  
            RegWrite = 1;
        end
        4'b0001: begin // OR operation
            ALUOp = 8'b00000001;  
            RegWrite = 1;
        end
        4'b0010: begin // ADD operation
            ALUOp = 8'b00000010;  
            RegWrite = 1;
        end
        4'b0011: begin // SUB operation
            ALUOp = 8'b00000011;  
            RegWrite = 1;
        end
        4'b0100: begin // LD operation
            MemRead = 1;
            RegWrite = 1;
        end
        4'b0101: begin // STORE operation
            MemWrite = 1;
            // Assuming the address comes from the immediate field in the instruction
            address = 8'b00000001; // Set to a proper address logic based on your design
        end
        4'b0110: begin // JMP operation
            Jump = 1;
            address = 8'b00000100; // Set to a target address as needed
        end
        default: begin
            ALUOp = 8'b00000000;
            $display("Control Unit: Invalid operation");
        end
    endcase
end

endmodule
