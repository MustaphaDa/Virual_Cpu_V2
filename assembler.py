import re

class Assembler:
    def __init__(self):
        self.OPCODES = {
            "AND":   "0000",   # ALUOp = 4'b0000
            "OR":    "0001",   # ALUOp = 4'b0001
            "ADD":   "0010",   # ALUOp = 4'b0010
            "SUB":   "0011",   # ALUOp = 4'b0011
            "LD":    "0100",   # MemRead = 1
            "STORE": "0101",   # MemWrite = 1
            "JMP":   "0110"    # Jump = 1
        }
        
        self.binary_program = []
        self.symbol_table = {}
        
    def parse_register(self, reg_str):
        """Convert register string (R0-R7) to binary."""
        if not reg_str.startswith('R'):
            raise ValueError(f"Invalid register format: {reg_str}")
        reg_num = int(reg_str[1:])
        if reg_num < 0 or reg_num > 7:
            raise ValueError(f"Invalid register number: {reg_num}")
        return f"{reg_num:03b}"  # 3 bits for register (up to R7)

    def parse_immediate(self, imm_str):
        """Convert immediate value to binary."""
        try:
            imm = int(imm_str)
            if imm < 0 or imm > 15:  # 4-bit immediate
                raise ValueError(f"Immediate value out of range: {imm}")
            return f"{imm:04b}"
        except ValueError:
            raise ValueError(f"Invalid immediate value: {imm_str}")

    def assemble_instruction(self, line):
        """Convert a single assembly instruction to binary."""
        # Remove comments and strip whitespace
        line = re.sub(r'#.*$', '', line).strip()
        if not line:
            return None
            
        parts = line.split()
        opcode = parts[0].upper()
        
        if opcode not in self.OPCODES:
            raise ValueError(f"Invalid opcode: {opcode}")
            
        binary = self.OPCODES[opcode]
        
        # Handle different instruction formats
        if opcode in ["AND", "OR", "ADD", "SUB"]:
            # Format: OP Rd, Rs1, Rs2
            if len(parts) != 4:
                raise ValueError(f"Invalid format for {opcode}")
            rd = self.parse_register(parts[1])
            rs1 = self.parse_register(parts[2])
            rs2 = self.parse_register(parts[3])
            binary += rd + rs1 + rs2
            
        elif opcode in ["LD", "STORE"]:
            # Format: OP Rd, imm
            if len(parts) != 3:
                raise ValueError(f"Invalid format for {opcode}")
            rd = self.parse_register(parts[1])
            imm = self.parse_immediate(parts[2])
            binary += rd + imm
            
        elif opcode == "JMP":
            # Format: JMP imm
            if len(parts) != 2:
                raise ValueError(f"Invalid format for JMP")
            imm = self.parse_immediate(parts[1])
            binary += imm.zfill(4)
            
        return binary

    def assemble_program(self, assembly_code):
        """Assemble entire program."""
        self.binary_program = []
        
        # First pass: collect labels
        for line_num, line in enumerate(assembly_code):
            if ':' in line:
                label = line.split(':')[0].strip()
                self.symbol_table[label] = line_num
        
        # Second pass: generate binary
        for line in assembly_code:
            if ':' in line:
                line = line.split(':')[1].strip()
            try:
                binary = self.assemble_instruction(line)
                if binary:
                    self.binary_program.append(binary)
            except ValueError as e:
                print(f"Error assembling line '{line}': {e}")
                
        return self.binary_program

    def generate_verilog_memory_init(self):
        """Generate Verilog code to initialize instruction memory."""
        verilog_init = []
        for addr, instr in enumerate(self.binary_program):
            verilog_init.append(f"memory[{addr}] = 8'b{instr};")  # Ensure correct memory name
        return "\n".join(verilog_init)

# Sample assembly code
assembly_code = [
    "LD R1, 10",       # Load the value 10 into register R1
    "LD R2, 1",       # Load the value 1 into register R2
    "ADD R3, R1, R2"  # Add the values in R1 and R2, store result in R3
]

assembler = Assembler()
binary_program = assembler.assemble_program(assembly_code)
verilog_init = assembler.generate_verilog_memory_init()

# Output the generated binary and Verilog initialization code
print("Binary Program:", binary_program)
print("Verilog Initialization Code:\n", verilog_init)
