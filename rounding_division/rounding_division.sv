// Prompt
// Divide an input number by a power of two and round the result to the nearest integer. 
// The power of two is calculated using 2^(DIV_LOG2) where DIV_LOG2 is a module parameter. 
// Remainders of 0.5 or greater should be rounded up to the nearest integer. 
// If the output were to overflow, then the result should be saturated instead.

// Input and Output Signals
// din - Input number
// dout - Rounded result

module rounding_division #(parameter
  DIV_LOG2=3,
  OUT_WIDTH=32,
  IN_WIDTH=OUT_WIDTH+DIV_LOG2
)(
    input [IN_WIDTH-1:0] din,
    output logic [OUT_WIDTH-1:0] dout
);

  logic [OUT_WIDTH:0] temp;

    assign temp = din[IN_WIDTH-1:DIV_LOG2] + din[DIV_LOG2-1];
    assign dout = (temp[OUT_WIDTH] == 1 ? din[IN_WIDTH-1:DIV_LOG2] : temp[OUT_WIDTH-1:0]);



endmodule