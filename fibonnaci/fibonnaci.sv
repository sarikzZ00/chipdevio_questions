// Prompt
// Design a circuit which generates the Fibonacci sequence starting with 1 and 1 as the first two numbers.

// The Fibonacci sequence is a sequence of numbers where each number is the sum of the two previous numbers. 
//  formally this can be expressed as:

// F0 = 1
// F1 = 1
// Fn = Fn-1 + Fn-2 for n > 1.

// Following the definition of the Fibonacci sequence above we can see that the sequence is 1, 1, 2, 3, 5, 8, 13, etc.

// The sequence should be produced when the active low signal (resetn) becomes active. 
// In other words, the sequence should restart from 1 followed by another 1 (the Fibonacci sequence's initial condition) 
// as soon as resetn becomes active.

// Input and Output Signals
// clk - Clock signal
// resetn - Synchronous reset-low signal
// out - Current Fibonacci number
// Output signals during reset
// out - 1 when resetn is active (the first 1 of the Fibonacci sequence)

module fibonacci # (parameter DATA_WIDTH = 4) (
    input clk,
    input resetn,
    output logic [DATA_WIDTH-1:0] out
);
    logic [DATA_WIDTH-1:0] F_n_1;
    logic [DATA_WIDTH-1:0] F_n_2;
    logic [DATA_WIDTH-1:0] out_next;

    
    // //This is wrong
    // always_ff @(posedge clk) begin
    //     if (!resetn) begin
    //         out <= 1;
    //         F_n_1 <= 1;
    //         F_n_2 <= 1;
    //     end
    //     else begin
    //         out <= out_next;
    //         F_n_1 <= out; 
    //         F_n_2 <= F_n_1;
    //     end
    // end

    // assign out_next = F_n_1 + F_n_2;


    // This is right now, look exactly why
   always_ff @(posedge clk) begin
        if (!resetn) begin
            out <= 1;
            F_n_1 <= 1;
            F_n_2 <= 1;
        end
        else begin
            out <= F_n_1;
            F_n_1 <= out_next;
            F_n_2 <= F_n_1;
        end
    end

    assign out_next = F_n_1 + F_n_2;


endmodule