`timescale 1ns/1ps

module par_2_ser_shift_reg_tb;

  // Parameters
  parameter DATA_WIDTH = 4;
  
  // Inputs
  reg clk;
  reg resetn;
  reg [DATA_WIDTH-1:0] din;
  reg din_en;
  
  // Outputs
  wire [DATA_WIDTH-1:0] dout;
  
  // Internal variables
  integer file;

  // Instantiate the DUT (Device Under Test)
  par_2_ser_shift_reg #(.DATA_WIDTH(DATA_WIDTH)) dut (
    .clk(clk),
    .resetn(resetn),
    .din(din),
    .din_en(din_en),
    .dout(dout)
  );

  // Clock Generation
  always #5 clk = ~clk; // 100MHz clock, 10ns period

  // Stimulus
  initial begin
    // Open the file for writing results
    file = $fopen("shift_reg_output.txt", "w");
    
    // Print the header for the table with fixed-width columns
    $fwrite(file, "%-10s %-10s %-10s %-10s %-10s %-10s\n", "Time", "resetn", "din_en", "din", "shift_in", "dout");
    $fwrite(file, "------------------------------------------------------------\n");

    // Initialize inputs
    clk = 0;
    resetn = 0;
    din = 4'b1010; // Example input data in binary
    din_en = 0;

    // Wait for reset release
    #15 resetn = 1;
    
    // Load the input
    #10 din_en = 1;
    #10 din_en = 0; // Disable input, start shifting

    // Let the shifting happen over several cycles
    repeat(DATA_WIDTH) @(posedge clk);

    // Reset the system
    #10 resetn = 0;
    #10 resetn = 1;

    // Load new data and test again
    #10 din = 4'b1100; // Another example input in binary
    din_en = 1;
    #10 din_en = 0;
    
    repeat(DATA_WIDTH) @(posedge clk);

    // Finish simulation
    $fclose(file);
    $finish;
  end

  // Monitor signal changes and print to file in a neatly formatted table
  always @(posedge clk) begin
    $fwrite(file, "%-10t %-10b %-10b %-10b %-10b %-10b\n", $time, resetn, din_en, din, dut.shift_in, dout);
  end

endmodule
