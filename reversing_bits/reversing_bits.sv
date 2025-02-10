// Prompt
// Reverse the bits of an input value's binary representation.

// Input and Output Signals
// din - Input value
// dout - Bitwise reversed value

module reversing_bits # (parameter DATA_WIDTH = 32) (
    input [DATA_WIDTH-1:0] din,
    output logic [DATA_WIDTH-1:0] dout
);

always_comb begin
for (int i = 0; i < DATA_WIDTH; i++) begin
   dout[DATA_WIDTH - i - 1] = din[i];

end
end
endmodule