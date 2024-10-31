`timescale 1ns / 1ps

module testbench;
    // Declare inputs and outputs for the CPU
    reg [7:0] opcode;
    reg [7:0] A, B;
    wire [7:0] result;
    wire zero, carry, negative;

    // Instantiate the CPU (change `cpu` to the actual module name if different)
    cpu my_cpu (
        .opcode(opcode),
        .A(A),
        .B(B),
        .result(result),
        .zero(zero),
        .carry(carry),
        .negative(negative)
    );

    // Initialize and apply test cases
    initial begin
        // Test case 1: AND operation
        opcode = 8'b0000; A = 8'b11001100; B = 8'b10101010;
        #10;  // Wait for 10 time units
        
        // Check output (you can add more test cases)
        $display("Result: %b, Zero: %b, Carry: %b, Negative: %b", result, zero, carry, negative);
        
        // Add more test cases here
        
        // End the simulation
        $finish;
    end
endmodule
