`timescale 1ns / 1ps

module tb_second_largest();

  // Parameters
  localparam DATA_WIDTH = 32;

  // Inputs
  reg clk;
  reg resetn;
  reg [DATA_WIDTH-1:0] din;

  // Outputs
  wire [DATA_WIDTH-1:0] dout;

  // Internal signals for monitoring
  wire [DATA_WIDTH-1:0] first_largest;
  wire [DATA_WIDTH-1:0] second_largest;

  // File handle
  integer file;

  // Instantiate the Unit Under Test (UUT)
  second_largest #(.DATA_WIDTH(DATA_WIDTH)) uut (
    .clk(clk),
    .resetn(resetn),
    .din(din),
    .dout(dout)
  );

  // Connect internal signals for monitoring
  assign first_largest = uut.first_largest;
  assign second_largest = uut.second_largest;

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100 MHz clock
  end

  // Test sequence
  initial begin
    // Open file for writing
    file = $fopen("output_signals.txt", "w");
    if (file == 0) begin
      $display("Error: Could not open file for writing.");
      $finish;
    end

    // Initialize Inputs
    resetn = 0;
    din = 0;

    // Write header to file in table format
    $fwrite(file, "+------------+------------+----------------+------------------+------------+\n");
    $fwrite(file, "|    Time    |    din     | first_largest  | second_largest   |    dout    |\n");
    $fwrite(file, "+------------+------------+----------------+------------------+------------+\n");

    // Reset the design
    #10 resetn = 1;  // De-assert reset after 10 time units

    // Apply test vectors
    repeat (2) @(posedge clk);  // Wait for a few clock cycles

    // Test 1: Apply a series of values
    din = 10;
    @(posedge clk);
    print_signals();

    din = 20;
    @(posedge clk);
    print_signals();

    din = 15;
    @(posedge clk);
    print_signals();

    din = 30;
    @(posedge clk);
    print_signals();

    din = 25;
    @(posedge clk);
    print_signals();

    // Test 2: Apply a reset
    resetn = 0;
    @(posedge clk);
    resetn = 1;
    print_signals();

    // Test 3: Apply a new series of values after reset
    din = 5;
    @(posedge clk);
    print_signals();

    din = 50;
    @(posedge clk);
    print_signals();

    din = 40;
    @(posedge clk);
    print_signals();

    din = 45;
    @(posedge clk);
    print_signals();

    // Close table and file
    $fwrite(file, "+------------+------------+----------------+------------------+------------+\n");
    $fclose(file);
    $finish;
  end

  // Task to print the signals to file in table format
  task print_signals();
    begin
      $fwrite(file, "| %10t | %10d | %14d | %16d | %10d |\n", $time, din, first_largest, second_largest, dout);
    end
  endtask

endmodule
