`timescale 1ns/1ps

module palindrome_detect_tb;

  // Parameters
  parameter DATA_WIDTH = 32;

  // Signals
  logic  [DATA_WIDTH-1:0] din;
  logic dout;

  // Internal variables
  integer file;

  // Instantiate the Device Under Test (DUT)
  palindrome_detect #(.DATA_WIDTH(DATA_WIDTH)) dut (
    .din(din),
    .dout(dout)
  );

  // Stimulus
  initial begin
    // Open the file for writing results, checking for file open errors
    file = $fopen("model_palindrome_output.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file for writing.");
      $finish;
    end
    
    // Print header for the table
    $fwrite(file, "%-35s %-10s\n", "Input (din)", "Palindrome (dout)");
    $fwrite(file, "-----------------------------------------------\n");

    // Test case 1: Input is a palindrome (even number of bits)
    din = 32'b10000000000000000000000000000001; #10;
    $fwrite(file, "%b %-10b\n", din, dout);

    // Test case 2: Input is a palindrome (odd number of bits)
    din = 32'b10100000000000000000000000000101; #10;
    $fwrite(file, "%b %-10b\n", din, dout);

    // Test case 3: Input is not a palindrome
    din = 32'b11000000000000000000000000000011; #10;
    $fwrite(file, "%b %-10b\n", din, dout);

    // Test case 4: Input is all 0s (palindrome)
    din = 32'b00000000000000000000000000000000; #10;
    $fwrite(file, "%b %-10b\n", din, dout);

    // Test case 5: Input is all 1s (palindrome)
    din = 32'b11111111111111111111111111111111; #10;
    $fwrite(file, "%b %-10b\n", din, dout);

    // Test case 6: Random test pattern
    din = 32'b10101010101010101010101010101010; #10;
    $fwrite(file, "%b %-10b\n", din, dout);

    // Finish simulation and close the file
    $fclose(file); // Ensure that the file is properly closed

    // Ensure simulation has enough time to complete
    #10;
    $display("Simulation completed. Output written to model_palindrome_output.txt.");
    $finish;
  end

endmodule
