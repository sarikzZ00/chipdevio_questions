`timescale 1ns/1ps

module stopwatch_timer_tb;

  // Parameters
  parameter MAX = 99;

  // Signals
  reg clk;
  reg reset;
  reg start;
  reg stop;
  wire [15:0] count;

  // Internal variables
  integer file;

  // Instantiate the Device Under Test (DUT)
  stopwatch_timer #(.MAX(MAX)) dut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .stop(stop),
    .count(count)
  );

  // Clock Generation
  always #5 clk = ~clk; // 100MHz clock, 10ns period

  // Stimulus
  initial begin
    // Open the file for writing results, checking for file open errors
    file = $fopen("stopwatch_timer_output.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file.");
      $finish;
    end

    // Print header
    $fwrite(file, "Time\t\treset\tstart\tstop\tcount\n");
    $fwrite(file, "-----------------------------------------------------\n");

    // Initialize signals
    clk = 0;
    reset = 0;
    start = 0;
    stop = 0;

    // Test 1: Reset functionality
    reset = 1; #10;
    reset = 0; #10;
    $fwrite(file, "%0t\t%b\t%b\t%b\t%d\n", $time, reset, start, stop, count);

    // Test 2: Start counting
    start = 1; #50; // Allow counting for 5 clock cycles
    start = 0; #10;
    $fwrite(file, "%0t\t%b\t%b\t%b\t%d\n", $time, reset, start, stop, count);

    // Test 3: Stop the counter
    stop = 1; #20; // The counter should stop at this point
    stop = 0; #10;
    $fwrite(file, "%0t\t%b\t%b\t%b\t%d\n", $time, reset, start, stop, count);

    // Test 4: Start again and stop
    start = 1; #30; // Allow counting again
    stop = 1; #10; // Stop after 3 cycles
    start = 0; stop = 0; #10;
    $fwrite(file, "%0t\t%b\t%b\t%b\t%d\n", $time, reset, start, stop, count);

    // Test 5: Reset in the middle of counting
    start = 1; #30;
    reset = 1; #10; // Reset should set the counter to 0
    reset = 0; #10;
    $fwrite(file, "%0t\t%b\t%b\t%b\t%d\n", $time, reset, start, stop, count);

    // Finish simulation
    $fclose(file);
    $finish;
  end

  // Monitor signal changes and print to file
  always @(posedge clk) begin
    $fwrite(file, "%0t\t%b\t%b\t%b\t%d\n", $time, reset, start, stop, count);
  end

endmodule
