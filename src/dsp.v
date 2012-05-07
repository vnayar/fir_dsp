/**
 * Digitial Signal Processor top level.
 */

module dsp
  (input clk, reset,
   output [15:0] pc,
   input [67:0]  instr,
   output 		 mem_write,
   output [31:0] alu_out, write_data,
   input [31:0]  read_data);

   wire 		 mem_to_reg, branch, alu_src, reg_dst, reg_write, jump;
   wire [2:0] 	 alu_control;

endmodule // dsp
