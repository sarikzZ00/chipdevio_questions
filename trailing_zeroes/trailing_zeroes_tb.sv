`timescale 1ns/1ps

module trailing_zeroes_tb;

  // Parameters
  parameter DATA_WIDTH = 4; // Example data width

  // Signals
  logic [DATA_WIDTH-1:0] din;  // Input value
  logic [$clog2(DATA_WIDTH):0] dout; // Output value

  // Internal variables
  integer file;

  // Instantiate the Device Under Test (DUT)
  trailing_zeroes #(.DATA_WIDTH(DATA_WIDTH)) dut (
    .din(din),
    .dout(dout)
  );

  // Stimulus
  initial begin
    // Open the file for writing results, checking for file open errors
    file = $fopen("trailing_zeroes_output.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file.");
      $finish;
    end
    
    // Print the header for the table with fixed-width columns
    $fwrite(file, "%-10s %-10s %-10s\n", "Time", "din", "dout");
    $fwrite(file, "--------------------------------\n");

    // Test various inputs for trailing zeroes
    din = 4'b0000; #10;  // Test input with all 0's (should return 8)
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    din = 4'b0001; #10;  // Test input with no trailing 0's (should return 0)
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    din = 4'b0100; #10;  // Test input with 2 trailing 0's
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    din = 4'b1110; #10;  // Test input with 1 trailing 0's
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    din = 8'b1000; #10;  // Test input with 3 trailing 0's
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    // Finish simulation and close the file
    $fclose(file);
    $finish;
  end

endmodule
