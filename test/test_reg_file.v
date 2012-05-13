/**
 * Test - Register File.
 * Assure simultaneous reads and write are supported.
 */
module test_reg_file();
   
   reg         clk;
   reg         we1, we2;
   reg [3:0]   a1, a2, wa1, wa2;
   reg [31:0]  wd1, wd2;
   wire [31:0] rd1, rd2;

   // Instantiate the device-under-test (dut).
   reg_file#(1) dut(clk, we1, we2, a1, a2, wa1, wa2, wd1, wd2, rd1, rd2);

   // generate clock
   always begin
      clk = 1; #5;
      clk = 0; #5;
   end
   
   // Apply test inputs one at a time and verify outputs.
   initial begin
      // Initialize a circular buffer.
      $display("Starting Test.");

      // Write into registers 1 and 2.
      we1 = 1; we2 = 1; a1 = 0; a2 = 0; wa1 = 1; wa2 = 2; wd1 = 10; wd2 = 20; #11;

      // Read registers 1 and 2.
      we1 = 0; we2 = 0; a1 = 1; a2 = 2; #10;
      if (rd1 !== 10 || rd2 !== 20)
        $display("Read failed: rd1=%h, rd2=%h.", rd1, rd2);

      // Check the zero-register.
      a1 = 0; a2 = 0; #10;
      if (rd1 !== 0 || rd2 !== 0)
        $display("Read $0 failed:  rd1=%h, rd2=%h.", rd1, rd2);

      $display("Test Complete.");
   
   end // initial begin
endmodule // test_reg_file

