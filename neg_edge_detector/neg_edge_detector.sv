// Prompt
// Build a circuit that pulses dout one cycle after the falling edge of din. 
// A pulse is defined as writing a single-cycle 1 as shown in the examples below. 
// When resetn is asserted, the value of din should be treated as 0.

// Bonus - can you enhance your design to pulse dout on the same cycle as the rising edge? 
// Note that this enhancement will not pass our test suite, but is still a useful exercise.

// Input and Output Signals
// clk - Clock signal
// resetn - Synchronous reset-low signal
// din - Input signal
// dout - Output signal
// Output signals during reset
// dout - 0 when resetn is active

module neg_edge_detector (
    input clk,
    input resetn,
    input din,
    output logic dout
);

logic din_dly; //din_delayed

always_ff @(posedge clk) begin
    if (!resetn) begin
        din_dly <= 0;
        dout <= 0;
    end
    else begin
        din_dly <= din;
        dout <= din_dly & ~din;
    end
end


endmodule