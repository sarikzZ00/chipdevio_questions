// Prompt
// Given an input binary value, output the number of bits that are equal to 1.

// Input and Output Signals
// din - Input value
// dout - Number of 1's in the input value

module counting_ones #(parameter DATA_WIDTH = 4) (
    input [DATA_WIDTH-1:0] din,
    output logic [$clog2(DATA_WIDTH):0] dout
);

logic [$clog2(DATA_WIDTH):0] dout_temp;
always_comb begin 
    dout_temp = '0;
    foreach(din[i]) 
        dout_temp += din[i];
end

assign dout = dout_temp;
endmodule
