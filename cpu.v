// CPU module with instruction execution
module CPU(
    input wire clk,
    input wire reset,
    output wire [7:0] result,
    output wire zero,
    output wire carry,
    output wire negative
);

// Internal registers and memory
reg [7:0] pc;                    // Program Counter
reg [7:0] instruction_memory[0:255]; // Instruction memory
reg [7:0] data_memory[0:255];    // Data memory
reg [7:0] registers[0:7];        // Register file with 8 registers
reg [7:0] current_instruction;   // Current instruction register

// Internal signals
wire [3:0] opcode;
wire [1:0] rd, rs1, rs2;
wire [3:0] immediate;
wire [7:0] alu_result;
wire [7:0] alu_op;

// Control signals
wire mem_read, mem_write, reg_write, branch;
wire [7:0] mem_data;

// Instruction decode
assign opcode = current_instruction[7:4];    // Upper 4 bits are opcode
assign rd = current_instruction[3:2];        // Destination register (2 bits)
assign rs1 = current_instruction[1:0];       // Source register 1 (2 bits)
assign rs2 = current_instruction[3:2];       // Source register 2 (2 bits)
assign immediate = current_instruction[3:0];  // Immediate value (4 bits)

// Initialize registers and memory
initial begin
    pc = 0;
    current_instruction = 0;
    
    // Initialize registers
    registers[0] = 0;
    registers[1] = 0;
    registers[2] = 0;
    registers[3] = 0;
    registers[4] = 0;
    registers[5] = 0;
    registers[6] = 0;
    registers[7] = 0;
    
    // Initialize memories
    // We'll load program in testbench
end

// Program counter update
always @(posedge clk or posedge reset) begin
    if (reset) begin
        pc <= 0;
    end else begin
        pc <= pc + 1;
    end
end

// Instruction fetch
always @(posedge clk) begin
    if (!reset) begin
        current_instruction <= instruction_memory[pc];
    end
end

// Control Unit instantiation
ControlUnit control_unit (
    .opcode(opcode),
    .ALUOp(alu_op),
    .MemRead(mem_read),
    .MemWrite(mem_write),
    .RegWrite(reg_write),
    .Branch(branch),
    .Jump(),                // Not used in this implementation
    .address()             // Not used in this implementation
);

// ALU instantiation
Alu alu (
    .opcode(alu_op),
    .A(registers[rs1]),
    .B(registers[rs2]),
    .Result(alu_result),
    .Zero(zero),
    .Carry(carry),
    .Negative(negative)
);

// Execute stage - Register write and memory operations
always @(posedge clk) begin
    if (!reset) begin
        if (reg_write) begin
            case (opcode)
                4'b0000: registers[rd] <= alu_result;           // AND
                4'b0001: registers[rd] <= alu_result;           // OR
                4'b0010: registers[rd] <= alu_result;           // ADD
                4'b0011: registers[rd] <= alu_result;           // SUB
                4'b0100: registers[rd] <= data_memory[immediate]; // LD
            endcase
        end
        
        if (mem_write) begin
            data_memory[immediate] <= registers[rs1];           // STORE
        end
    end
end

// Output assignment
assign result = alu_result;

// Debug output
always @(posedge clk) begin
    $display("Time=%0t PC=%0d Instruction=%b", $time, pc, current_instruction);
    $display("Registers: R0=%0d R1=%0d R2=%0d R3=%0d", 
             registers[0], registers[1], registers[2], registers[3]);
    $display("ALU Result=%0d Zero=%b Carry=%b Negative=%b",
             alu_result, zero, carry, negative);
end

endmodule