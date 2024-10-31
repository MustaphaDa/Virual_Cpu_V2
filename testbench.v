module testbench;
    reg clk;
    reg reset;
    wire [7:0] result;
    wire zero, carry, negative;

    // Instantiate the Memory module
    wire [7:0] instruction_memory [0:255];  // Define instruction memory array
    wire [7:0] data_memory [0:255];          // Define data memory array

    // Instantiate CPU
    CPU cpu (
        .clk(clk),
        .reset(reset),
        .result(result),
        .zero(zero),
        .carry(carry),
        .negative(negative),
        .instruction_memory(instruction_memory), // Connect instruction memory
        .data_memory(data_memory)                // Connect data memory
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Load the initial program into instruction memory
        instruction_memory[0] = 8'b01000100; // LD R1, 4    ; Load value 4 into R1
        instruction_memory[1] = 8'b01001000; // LD R2, 8    ; Load value 8 into R2
        instruction_memory[2] = 8'b00100110; // ADD R3,R1,R2 ; R3 = R1 + R2
        instruction_memory[3] = 8'b01010011; // STORE R3, 3  ; Store R3 to memory[3]
        
        // Initialize data memory values
        data_memory[4] = 8'd4;  // Value to be loaded into R1
        data_memory[8] = 8'd8;  // Value to be loaded into R2

        // Start execution
        reset = 1;
        #20 reset = 0;

        // Wait for program execution
        #100;

        // Display final results
        $display("\nFinal Results:");
        $display("R1 = %d", cpu.registers[1]);
        $display("R2 = %d", cpu.registers[2]);
        $display("R3 = %d", cpu.registers[3]);
        $display("Memory[3] = %d", data_memory[3]);

        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%0t reset=%b pc=%d instruction=%b result=%b zero=%b",
                 $time, reset, cpu.pc, cpu.current_instruction, result, zero);
    end

endmodule
