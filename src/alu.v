/**
 * Arithmetic Logic Unit.
 */
module alu
  (
   input [2:0]       ctrl,
   input [31:0]      src_a, src_b,
   output reg [31:0] result);

   always @(*) begin
      case (ctrl)
        0: result = src_a & src_b;
        1: result = src_a | src_b;
        2: result = src_a + src_b;
        4: result = src_a & ~src_b;
        5: result = src_a | ~src_b;
        6: result = src_a - src_b;
        7: result = src_a < src_b;
        default: result = src_a + src_b;
      endcase // case (ctrl)
   end // always begin
endmodule // alu
   