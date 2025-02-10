`timescale 1ns / 1ps

module fifo_tb;
    parameter DATA_WIDTH = 8;
    
    // Testbench signals
    logic clk;
    logic resetn;
    logic [DATA_WIDTH-1:0] din;
    logic wr;
    logic [DATA_WIDTH-1:0] dout;
    logic full;
    logic empty;
    
    // Instantiate FIFO
    model #(DATA_WIDTH) DUT (
        .clk(clk),
        .resetn(resetn),
        .din(din),
        .wr(wr),
        .dout(dout),
        .full(full),
        .empty(empty)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    initial begin
        $dumpfile("multi_bit_fifo.dump");
    $   dumpvars( 0, multi_bit_fifo_tb_tb);
        // Initialize signals
        clk = 0;
        resetn = 0;
        din = 0;
        wr = 0;
        
        // Apply reset
        #10 resetn = 1;
        
        // Write first entry
        #10 din = 8'hA5; wr = 1;
        #10 wr = 0;
        
        // Write second entry
        #10 din = 8'h5A; wr = 1;
        #10 wr = 0;
        
        // Attempt to write more entries while full
        #10 din = 8'hFF; wr = 1;
        #10 wr = 0;
        

        #50;
        
        // Finish simulation
        $stop;
    end
    
    // Monitor signals
    initial begin
        $monitor("Time: %0t | Reset: %b | Wr: %b | Din: %h | Dout: %h | Full: %b | Empty: %b", 
                 $time, resetn, wr, din, dout, full, empty);
    end
    
endmodule


