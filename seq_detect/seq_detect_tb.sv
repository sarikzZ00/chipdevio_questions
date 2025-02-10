`timescale 1ns/1ps

module tb_seq_detect;

  // Signals
  logic clk;
  logic resetn;
  logic din;
  logic dout;

  // Internal variables
  integer file;

  // Instantiate the Device Under Test (DUT)
  seq_detect dut (
    .clk(clk),
    .resetn(resetn),
    .din(din),
    .dout(dout)
  );

  // Clock Generation
  always #5 clk = ~clk; // 100MHz clock, 10ns period

  // Stimulus
  initial begin
    // Open the file for writing results, checking for file open errors
    file = $fopen("seq_detect_output.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file.");
      $finish;
    end
    
    // Print header for the table
    $fwrite(file, "%-10s %-10s %-10s %-20s %-20s\n", "Time", "din", "dout", "State", "Next State");
    $fwrite(file, "------------------------------------------------------------------------\n");

    // Initialize signals
    clk = 0;
    resetn = 0;
    din = 0;

    // Test case: Reset sequence
    #15 resetn = 1;

    // Apply a pattern with "1010" sequence
    din = 1; #10; // First bit of 1010
    din = 0; #10; // Second bit of 1010
    din = 1; #10; // Third bit of 1010
    din = 0; #10; // Fourth bit of 1010

    // Continue with more data
    din = 1; #10;
    din = 1; #10;
    din = 0; #10;
    din = 1; #10;
    din = 0; #10;

    // Apply a reset in the middle of detection
    resetn = 0; #10;
    resetn = 1; #10;

    // Random input pattern
    din = 0; #10;
    din = 1; #10;
    din = 0; #10;
    din = 1; #10;

    // Finish simulation
    $fclose(file);
    $finish;
  end

  // Monitor signal changes and log to file in a formatted way
  always @(posedge clk) begin
    // Log formatted information into the file using hierarchical access
    $fwrite(file, "%-10t %-10b %-10b %-20s %-20s\n", $time, din, dout, dut.state.name(), dut.state_next.name());
  end

endmodule
