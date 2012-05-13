/**
 * Test - Arithmetic Logic Unit.
 * Basic sanity check to make sure the language is understood.
 */
module test_alu();
   
   reg [2:0]   ctrl;
   reg [31:0]  src_a, src_b;
   wire [31:0] result;
   

   // Instantiate the device-under-test (dut).
   alu dut(ctrl, src_a, src_b, result);

   // Apply test inputs one at a time and verify outputs.
   initial begin
      $display("Starting Test.");

      // Read the first instruction.
      ctrl = 0; src_a = 'hF0F0; src_b = 'hF00F; #10;
      if (result !== 'hF000) $display("AND operation failed:  %h", result);

      ctrl = 1; #10;
      if (result !== 'hF0FF) $display("OR operation failed:  %h", result);

      ctrl = 2; #10;
      if (result !== 'h1E0FF) $display("ADD operation failed:  %h", result);

      ctrl = 6; #10;
      if (result !== 'hE1) $display("SUB operation failed:  %h", result);

      ctrl = 7; #10;
      if (result !== 0) $display("SLT greater than test failed:  %h", result);

      src_a = 'hF00F; src_b = 'hF0F0; #10;
      if (result !== 1) $display("SLT less than test failed:  %h", result);

      src_a = 'hF00F; src_b = 'hF00F; #10;
      if (result !== 0) $display("SLT equal test failed:  %h", result);
        
      $display("Test Complete.");

   end // initial begin
endmodule // test_imem

