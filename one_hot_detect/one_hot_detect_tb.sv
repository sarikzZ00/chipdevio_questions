`timescale 1ns/1ps

module tb_one_hot_detect;

  // Parameters
  parameter DATA_WIDTH = 32;

  // Signals
  logic  [DATA_WIDTH-1:0] din;
  logic onehot;

  // Instantiate the Device Under Test (DUT)
  one_hot_detect #(.DATA_WIDTH(DATA_WIDTH)) dut (
    .din(din),
    .onehot(onehot)
  );

  // Stimulus
  initial begin
    // Print header for easy readability
    $display("Time       din (binary)                        onehot");
    $display("--------------------------------------------------------");

    // Test 1: Input is 0 -> Expected output: onehot = 0
    din = 32'b00000000000000000000000000000000;
    #10; // Wait for 10 ns
    $display("%0t      %b      %b", $time, din, onehot);

    // Test 2: Input is 1 (one-hot value) -> Expected output: onehot = 1
    din = 32'b00000000000000000000000000000001;
    #10; // Wait for 10 ns
    $display("%0t      %b      %b", $time, din, onehot);

    // Test 3: Input is 2 (one-hot value) -> Expected output: onehot = 1
    din = 32'b00000000000000000000000000000010;
    #10; // Wait for 10 ns
    $display("%0t      %b      %b", $time, din, onehot);

    // Test 4: Input is 3 (not a one-hot value) -> Expected output: onehot = 0
    din = 32'b00000000000000000000000000000011;
    #10; // Wait for 10 ns
    $display("%0t      %b      %b", $time, din, onehot);

    // Test 5: Input is 8 (one-hot value) -> Expected output: onehot = 1
    din = 32'b00000000000000000000000000001000;
    #10; // Wait for 10 ns
    $display("%0t      %b      %b", $time, din, onehot);

    // Test 6: Input is all 1's (not a one-hot value) -> Expected output: onehot = 0
    din = 32'b11111111111111111111111111111111;
    #10; // Wait for 10 ns
    $display("%0t      %b      %b", $time, din, onehot);

    // Test 7: Random test input
    din = 32'b00000000000000001000000000000000;
    #10; // Wait for 10 ns
    $display("%0t      %b      %b", $time, din, onehot);

    // Finish the simulation
    $finish;
  end

endmodule
