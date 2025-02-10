`timescale 1ns / 1ps

module tb_rounding_division;

  // Parameters
  localparam DIV_LOG2 = 3;  // Example power of 2 division (2^3 = 8)
  localparam OUT_WIDTH = 32;
  localparam IN_WIDTH = OUT_WIDTH + DIV_LOG2;

  // Inputs
  logic [IN_WIDTH-1:0] din;

  // Outputs
  logic [OUT_WIDTH-1:0] dout;

  // Instantiate the Unit Under Test (UUT)
  rounding_division #(.DIV_LOG2(DIV_LOG2), .OUT_WIDTH(OUT_WIDTH), .IN_WIDTH(IN_WIDTH)) uut (
    .din(din),
    .dout(dout)
  );

  // File handle for output
  integer file;

  // Test sequence
  initial begin
    // Open file for writing
    file = $fopen("division_results.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file for writing.");
      $finish;
    end

    // Write header to file
    $fwrite(file, "%-20s %-20s %-20s %-64s %-33s\n", "Time", "Decimal din", "Decimal dout", "Binary din", "Binary dout");

    // Test case 1: Basic division
    din = 64;  // 64 / 8 = 8
    #10 print_signals();

    // Test case 2: Division with rounding down
    din = 65;  // 65 / 8 = 8.125 -> 8
    #10 print_signals();

    // Test case 3: Division with rounding up
    din = 68;  // 68 / 8 = 8.5 -> 9
    #10 print_signals();

    // Test case 4: Maximum input without overflow
    din = (1 << (IN_WIDTH - 1)) - 1;  // Max positive value
    #10 print_signals();

    // Test case 5: Overflow situation
    din = (1 << (IN_WIDTH - 1));  // Overflow value
    #10 print_signals();

    // Test case 6: Division with large positive input
    din = (1 << (IN_WIDTH - 2)) + (1 << (IN_WIDTH - 3));  // Large positive value
    #10 print_signals();

    // Close file and end of test
    $fwrite(file, "End of Test\n");
    $fclose(file);
    $finish;
  end

  // Task to print the signals to file
  task print_signals();
    begin
      $fwrite(file, "%-20t %-20d %-20d %-64b %-33b\n", $time, din, dout, din, dout);
    end
  endtask

endmodule
