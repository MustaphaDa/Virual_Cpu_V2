# Makefile for CPU simulation

# Compiler settings
IVERILOG = iverilog
VVP = vvp
WAVE_VIEWER = gtkwave

# Source files
SOURCES = cpu.v alu.v control_unit.v memory.v testbench.v
TARGET = cpu_sim
WAVE_FILE = cpu_wave.vcd

.PHONY: all clean run wave

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(IVERILOG) -o $(TARGET) $(SOURCES)

run: $(TARGET)
	$(VVP) $(TARGET)

wave: run
	$(WAVE_VIEWER) $(WAVE_FILE)

clean:
	rm -f $(TARGET) $(WAVE_FILE)