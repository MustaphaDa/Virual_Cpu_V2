# Define variables
VLOG = iverilog
VVP = vvp
SRC = cpu.v control_unit.v alu.v memory.v registers.v
TESTBENCH = testbench.v  # Replace with your actual testbench filename
OUTPUT = cpu_sim

# Define the default target
all: $(OUTPUT)

# Compile Verilog files
$(OUTPUT): $(SRC) $(TESTBENCH)
	$(VLOG) -o $(OUTPUT) $(SRC) $(TESTBENCH)

# Run the simulation
run: $(OUTPUT)
	$(VVP) $(OUTPUT)

# Clean up generated files
clean:
	rm -f $(OUTPUT) *.vcd

# Phony targets
.PHONY: all run clean
