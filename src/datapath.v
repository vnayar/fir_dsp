/**
 * Data Path to tie together main components.
 */
module datapath
  (
   input 		 clk, reset,
   input 		 mem_to_reg, pcsrc,
   input 		 alu_src, reg_dst,
   input 		 reg_write, jump,
   input [2:0] 	 alu_control,
   output [31:0] pc,
   input [31:0]  instr,
   output [31:0] alu_out, write_data,
   input [31:0]  read_data);

endmodule // datapath
