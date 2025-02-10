`timescale 1ns/1ps

module fibonacci_tb;

  // Signals
  reg clk;
  reg resetn;
  wire [3:0] out;

  // Internal variables
  integer file;

  // Instantiate the Device Under Test (DUT)
  fibonacci dut (
    .clk(clk),
    .resetn(resetn),
    .out(out)
  );

  // Clock Generation
  always #5 clk = ~clk; // 100MHz clock, 10ns period

  // Stimulus
  initial begin
    // Open the file for writing results, checking for file open errors
    file = $fopen("fibonacci_output.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file.");
      $finish;
    end
    
    // Print the header for the table with fixed-width columns
    $fwrite(file, "%-10s %-10s %-10s\n", "Time", "resetn", "out");
    $fwrite(file, "------------------------------\n");

    // Initialize signals
    clk = 0;
    resetn = 0;

    // Apply reset for a few cycles to initialize Fibonacci sequence
    #15 resetn = 1;

    // Allow the Fibonacci sequence to generate numbers for a few cycles
    repeat(10) @(posedge clk);

    // Assert reset again to see the Fibonacci sequence restart
    #10 resetn = 0;
    #10 resetn = 1;

    // Allow more Fibonacci numbers to be generated
    repeat(10) @(posedge clk);

    // Finish simulation, flush the file, and close it
    $fclose(file);
    $finish;
  end

  // Monitor signal changes and print to file
  always @(posedge clk) begin
    $fwrite(file, "%-10t %-10b %-10d\n", $time, resetn, out);
  end

endmodule
