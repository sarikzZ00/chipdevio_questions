`timescale 1ns/1ps

module ser_2_par_shift_reg_tb;

  // Parameters
  parameter DATA_WIDTH = 4;
  
  // Inputs
  reg clk;
  reg resetn;
  reg din;
  
  // Outputs
  wire [DATA_WIDTH-1:0] dout;
  
  // Internal variables
  integer file;

  // Instantiate the DUT (Device Under Test)
  ser_2_par_shift_reg #(.DATA_WIDTH(DATA_WIDTH)) dut (
    .clk(clk),
    .resetn(resetn),
    .din(din),
    .dout(dout)
  );

  // Clock Generation
  always #5 clk = ~clk; // 100MHz clock, 10ns period

  // Stimulus
  initial begin
    // Open the file for writing results
    file = $fopen("bit_shift_reg_output.txt", "w");
    
    // Print the header for the table with fixed-width columns
    $fwrite(file, "%-10s %-10s %-10s %-10s %-10s\n", "Time", "resetn", "din", "shift_in", "dout");
    $fwrite(file, "-------------------------------------------------\n");

    // Initialize inputs
    clk = 0;
    resetn = 0;
    din = 0; // Initial input

    // Wait for reset release
    #15 resetn = 1;
    
    // Input sequence of bits (shift in values)
    din = 1'b1; #10;
    din = 1'b0; #10;
    din = 1'b1; #10;
    din = 1'b1; #10;
    
    // Continue with more bit shifts
    din = 1'b0; #10;
    din = 1'b0; #10;
    din = 1'b1; #10;

    // Assert reset again and observe the output
    #10 resetn = 0;
    #10 resetn = 1;

    // Provide new input sequence after reset
    din = 1'b1; #10;
    din = 1'b1; #10;
    din = 1'b0; #10;
    
    // Finish simulation
    $fclose(file);
    $finish;
  end

  // Monitor signal changes and print to file in a neatly formatted table
  always @(posedge clk) begin
    $fwrite(file, "%-10t %-10b %-10b %-10b %-10b\n", $time, resetn, din, dut.shift_in, dout);
  end

endmodule
