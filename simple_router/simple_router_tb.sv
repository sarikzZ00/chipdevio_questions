module simple_router_tb;

  // Parameters
  parameter DATA_WIDTH = 32;

  // Testbench Signals
  logic [DATA_WIDTH-1:0] din;
  logic din_en;
  logic [1:0] addr;
  logic [DATA_WIDTH-1:0] dout0;
  logic [DATA_WIDTH-1:0] dout1;
  logic [DATA_WIDTH-1:0] dout2;
  logic [DATA_WIDTH-1:0] dout3;

  // Instantiate the simple_router module
  simple_router #(DATA_WIDTH) uut (
    .din(din),
    .din_en(din_en),
    .addr(addr),
    .dout0(dout0),
    .dout1(dout1),
    .dout2(dout2),
    .dout3(dout3)
  );

  // Test procedure
  initial begin
    $dumpfile("simple_router.dump");
    $dumpvars( 0, simple_router_tb);
    // Initialize inputs
    din = 0;
    din_en = 0;
    addr = 0;

    // Wait for global reset
    #10;

    // Test Case 1: Disable din_en
    din = 32'hA5A5A5A5;
    addr = 2'b00;
    din_en = 0;
    #10;
    $display("Test Case 1: din_en=0");
    check_outputs(32'h0, 32'h0, 32'h0, 32'h0);

    // Test Case 2: Enable din_en, addr=00
    din_en = 1;
    #10;
    $display("Test Case 2: din_en=1, addr=00");
    check_outputs(32'hA5A5A5A5, 32'h0, 32'h0, 32'h0);

    // Test Case 3: addr=01
    addr = 2'b01;
    #10;
    $display("Test Case 3: din_en=1, addr=01");
    check_outputs(32'h0, 32'hA5A5A5A5, 32'h0, 32'h0);

    // Test Case 4: addr=10
    addr = 2'b10;
    #10;
    $display("Test Case 4: din_en=1, addr=10");
    check_outputs(32'h0, 32'h0, 32'hA5A5A5A5, 32'h0);

    // Test Case 5: addr=11
    addr = 2'b11;
    #10;
    $display("Test Case 5: din_en=1, addr=11");
    check_outputs(32'h0, 32'h0, 32'h0, 32'hA5A5A5A5);

    // Test Case 6: Change din value, addr=11
    din = 32'h5A5A5A5A;
    #10;
    $display("Test Case 6: Change din value, addr=11");
    check_outputs(32'h0, 32'h0, 32'h0, 32'h5A5A5A5A);

    // Finish simulation
    $finish;
  end

  // Task to check the outputs
  task check_outputs(input [DATA_WIDTH-1:0] expected_dout0,
                     input [DATA_WIDTH-1:0] expected_dout1,
                     input [DATA_WIDTH-1:0] expected_dout2,
                     input [DATA_WIDTH-1:0] expected_dout3);
    begin
      if (dout0 !== expected_dout0) $display("ERROR: dout0 is %h, expected %h", dout0, expected_dout0);
      if (dout1 !== expected_dout1) $display("ERROR: dout1 is %h, expected %h", dout1, expected_dout1);
      if (dout2 !== expected_dout2) $display("ERROR: dout2 is %h, expected %h", dout2, expected_dout2);
      if (dout3 !== expected_dout3) $display("ERROR: dout3 is %h, expected %h", dout3, expected_dout3);
    end
  endtask

endmodule





//$dumpfile("filename.dump");

//$dumpvars( 0, PE_affine_tb);