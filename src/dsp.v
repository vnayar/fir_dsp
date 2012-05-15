/**
 * Digitial Signal Processor.
 * This is the module of what will be the DSP chip.  Replacable components
 * such as the data memory and instruction memory are outside of this module.
 * The DSP consists of two main parts:
 *   - datapath - Chips and busses where main data manipulation occurs
 *   - controller - Chip selects, write-enables, instruction decoding
 */

module dsp
  (input clk, reset,
   output [15:0] pc,     // Instruction memory read-address
   input [63:0]  instr,  // Instruction memory read-data
   output        dm1_we, dm2_we,
   output [15:0] dm1_a, dm2_a,
   output [31:0] dm1_wd, dm2_wd,
   input [31:0]  dm1_rd, dm2_rd);

   // Program Sequencer
   wire          loop_we;
   // Register File
   wire          rf1_we1, rf2_we2, rf2_we1, rf2_we2;
   // Data Address Generator
   wire          dag1_re, dag2_re, dag1_we, dag2_we;
   // ALU
   wire [2:0]    alu1_ctrl, alu2_ctrl;

   // TODO:  Add mux based control signals.
   
   //           opcodeA1      funcA1        opcodeD1
   controller c(instr[63:68], instr[45:42], instr[41:38], 
   //           opcodeA2      funcA2        opcodeD2
                instr[31:26], instr[13:10], instr[9:6],
                dm1_we, dm2_we,
                loop_we,
                rf1_we1, rf1_we2, rf2_we1, rf2_we2,
                dag1_re, dag2_re, dag1_we, dag2_we,
                alu1_ctrl, alu2_ctrl);
   datapath dp(clk, reset, pc, instr, 
               dm1_a, dm2_a, dm1_wd, dm2_wd, dm1_rd, dm2_rd
               dm1_we, dm2_we,
               loop_we,
               rf1_we1, rf1_we2, rf2_we1, rf2_we2,
               dag1_re, dag2_re, dag1_we, dag2_we,
               alu1_ctrl, alu2_ctrl);

endmodule // dsp
