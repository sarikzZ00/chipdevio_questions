// Prompt
// Find the number of trailing 0s in the binary representation of the input (din). 
// If the input value is all 0s, the number of trailing 0s is the data width (DATA_WIDTH)

// Input and Output Signals
// din - Input value
// dout - Number of trailing 0s

module trailing_zeroes #(parameter DATA_WIDTH = 4) (
    input [DATA_WIDTH-1:0] din,
    output logic [$clog2(DATA_WIDTH) : 0] dout
);

logic [$clog2(DATA_WIDTH) : 0] num_zeroes;

always_comb begin 
    num_zeroes = '0;
    if (din == 0) begin
        num_zeroes = DATA_WIDTH;
    end
    else begin
    for (int i = 0; i < DATA_WIDTH; i++) begin
        if (din[i] == 0) begin
            num_zeroes += 1;
        end
        else begin
            i = DATA_WIDTH; //break the loop, once find the first one
        end
    end
    end
end

assign dout = num_zeroes;

endmodule