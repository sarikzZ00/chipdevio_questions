`timescale 1ns/1ps

module counting_ones_tb;

  // Parameters
  parameter DATA_WIDTH = 4; // Example input width

  // Signals
  logic [DATA_WIDTH-1:0] din;  // Input value
  logic [$clog2(DATA_WIDTH):0] dout; // Output value

  // Internal variables
  integer file;

  // Instantiate the Device Under Test (DUT)
  counting_ones #(.DATA_WIDTH(DATA_WIDTH)) dut (
    .din(din),
    .dout(dout)
  );

  // Stimulus
  initial begin
    // Open the file for writing results, checking for file open errors
    file = $fopen("bit_counter_output.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file.");
      $finish;
    end
    
    // Print the header for the table with fixed-width columns
    $fwrite(file, "%-10s %-10s %-10s\n", "Time", "din", "dout");
    $fwrite(file, "--------------------------------\n");

    // Initialize signals and test various inputs
    din = 8'b00000000; #10;  // Test input with no 1's
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    din = 8'b11111111; #10;  // Test input with all 1's
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    din = 8'b10101010; #10;  // Test input with alternating 1's
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    din = 8'b11001100; #10;  // Test input with four 1's
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    din = 8'b10000001; #10;  // Test input with two 1's
    $fwrite(file, "%-10t %-10b %-10d\n", $time, din, dout);

    // Finish simulation and close the file
    $fclose(file);
    $finish;
  end

endmodule
