/**
 * Test - Data Address Generator
 * The DAG is a complex and stateful component.  Testing it for correctness
 * is essential before work can be built upon it.
 */
module test_dag();
   
   reg clk;
   reg re;
   reg [2:0] cbs;
   reg       we;
   reg [31:0] wd;
   wire [15:0] a;

   // Instantiate the device-under-test (dut).
   dag dut(clk, re, cbs, we, wd, a);

   // generate clock
   always begin
      clk = 1; #5;
      clk = 0; #5;
   end
   
   // Apply test inputs one at a time.
   initial begin
      // Initialize a circular buffer.
      $display("Initializing Circular Buffer.");

      // Start at address 0xAB00, buffer is 8 bytes, and each read
      // advances the pointer by 2^1 = 2 bytes.
      //                             BASE      LENGTH   SIGN  EXP
      re = 0; cbs = 0; we = 1; wd = {16'hAB00, 12'h008, 1'b0, 3'b1}; #11;

      // Read the first address.
      re = 1; cbs = 0; we = 0; wd = 0; #10;
      if (a !== 'hAB00) $display("Read 1 failed (%h).", a);

      re = 1; cbs = 0; we = 0; wd = 0; #10;
      if (a !== 'hAB02) $display("Read 2 failed (%h).", a);

      re = 1; cbs = 0; we = 0; wd = 0; #10;
      if (a !== 'hAB04) $display("Read 3 failed (%h).", a);

      re = 1; cbs = 0; we = 0; wd = 0; #10;
      if (a !== 'hAB06) $display("Read 4 failed (%h).", a);

      re = 1; cbs = 0; we = 0; wd = 0; #10;
      if (a !== 'hAB00) $display("Read 5 (wrap) failed (%h).", a);

      $display("Test complete.");
   end // initial begin
endmodule // test_dag
