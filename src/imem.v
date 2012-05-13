/**
 * Instruction Memory.
 * ROM that is initialized from a file.
 * 16-bit addresses, 64-bit words
 * @ref David Harris and Sarah Harris, "Digital Design and Computer Architecture"
 */
module imem
  #(parameter FILE = "memfile.data")
  (
   input [15:0]  a,
   output [63:0] rd);

   reg [63:0]    ram[15:0];

   initial begin
      $readmemh(FILE, ram);
   end

   assign rd = ram[a];  // word aligned
endmodule // imem
