// Prompt
// One-hot values have a single bit that is a 1 with all other bits being 0. 
// Output a 1 if the input (din) is a one-hot value, and output a 0 otherwise.

// Input and Output Signals
// din - Input value
// onehot - 1 if the input is a one-hot value and 0 otherwise

module one_hot_detect #(parameter DATA_WIDTH = 32) (
    input [DATA_WIDTH-1:0] din,
    output logic onehot
);

 always_comb begin
        // A one-hot value has exactly one bit set to 1, so din & (din - 1) == 0
        // and din is not equal to 0 (din != 0).
        if (din != 0 && (din & (din - 1)) == 0) begin
            onehot = 1;
        end else begin
            onehot = 0;
        end
    end
endmodule