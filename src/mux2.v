/**
 * Multiplexer, 2-Port
 * The input size is parameterized.
 */
module mux2
  #(parameter WIDTH = 8)
   (input  [WIDTH-1:0] d0, d1,
	input              s,
	output [WIDTH-1:0] y);

	assign y = s ? d1 : d0;
endmodule // mux2
