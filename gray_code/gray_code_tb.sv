`timescale 1ns / 1ps

module gray_code_tb;

  parameter DATA_WIDTH = 4;
  logic clk;
  logic resetn;
  logic [DATA_WIDTH-1:0] out;

  gray_code #(DATA_WIDTH) dut (
    .clk(clk),
    .resetn(resetn),
    .out(out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("gray_code.dump");
    $dumpvars( 0, gray_code_tb);
    clk = 0;
    resetn = 0;
    
    // Apply reset
    #10 resetn = 1; 
    
    repeat (20) @(posedge clk);

    resetn = 0;
    repeat (2) @(posedge clk);
    resetn = 1;
    

    repeat (20) @(posedge clk);
    

    $stop;
  end

  // Monitor outputs
  initial begin
    $monitor("Time=%0t, resetn=%b, out=%b", $time, resetn, out);
  end

endmodule