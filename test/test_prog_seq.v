/**
 * Test - Program Sequencer
 * The Program Sequencer is responsible for moving simple loop logic to
 * hardware in a reduced number of clock cycles.  This is another critical
 * component for the DSP and must be tested thoroughly.
 */
module test_prog_seq();
   
   reg clk, reset;
   reg we;
   reg [11:0] iter, size;
   wire [15:0] addr;
   
   // Instantiate the device-under-test (dut).
   prog_seq dut(clk, reset, we, iter, size, addr);

   // generate clock
   always begin
      clk = 0; #5;
      clk = 1; #5;
   end
   
   // Apply test inputs one at a time.
   initial begin
      // Reset the program sequencer.
      $display("Resetting the Program Sequencer.");
      reset = 1; we = 0; iter = 0; size = 0; #11;
      if (addr !== 0) $display("Initial addr check failed (%h).", addr);

      // Check normal operation first.
      reset = 0; we = 0; iter = 0; size = 0; #10;
      if (addr !== 1) $display("Addr increment check failed (%h).", addr);

      // Initialize a loop.
      reset = 0; we = 1; iter = 2; size = 4; #10;
      if (addr !== 2) $display("Increment on loop init failed (%h).", addr);

      // Loop first instr at 0x02, last instr at 0x06.
      reset = 0; we=0; iter = 0; size = 0; #40;
      if (addr !== 6) $display("Last instruction not visited (%h).", addr);

      // See if we caught our jump.
      #10;
      if (addr !== 2) $display("Loop jump failed (%h).", addr);

      // Now see if this loop finishes.
      #50;
      if (addr !== 7) $display("Loop failed to terminate (%h).", addr);
      
      $display("Test complete.");
   end // initial begin
endmodule // test_dag
