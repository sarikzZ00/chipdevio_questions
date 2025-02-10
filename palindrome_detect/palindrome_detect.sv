// Prompt
// Given an input (din), output (dout) a 1 if its binary representation is a palindrome and a 0 otherwise.

// A palindrome binary representation means that the binary representation 
// has the same sequence of bits whether you read it from left to right or right to left. 
// Leading 0s are considered part of the input binary representation.

// Input and Output Signals
// din - Input value
// dout - 1 if the binary representation is a palindrome, 0 otherwise

module palindrome_detect #(parameter DATA_WIDTH = 32) (
    input [DATA_WIDTH-1:0] din,
    output logic dout
);
logic is_palindrome;

//double for loops?
always_comb begin
    is_palindrome = 1;
    for (int i = 0; i < DATA_WIDTH/2; i++) begin //if DATA_WIDTH = 4 (even), go from 0 to 1
            is_palindrome = (din[i] == din[DATA_WIDTH - 1 - i]) & is_palindrome;
    end
end
assign dout = is_palindrome;
endmodule