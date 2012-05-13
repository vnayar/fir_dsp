/**
 * Test - Instruction Memory.
 * Test the ability and format of the ROM data file.
 */
module test_imem();
   
   reg [15:0] a;
   wire [63:0] rd;

   // Instantiate the device-under-test (dut).
   imem#("test/testmem.dat") dut(a, rd);

   // Apply test inputs one at a time and verify outputs.
   initial begin
      $display("Starting Test.");

      // Read the first instruction.
      a = 0; #10;
      if (rd !== 'h0000_0000_0000_0000) $display("Read addr 0 failed:  %h", rd);

      a = 1; #10;
      if (rd !== 'hFEDC_BA98_7654_3210) $display("Read addr 1 failed:  %h", rd);

      $display("Test Complete.");

   end // initial begin
endmodule // test_imem

