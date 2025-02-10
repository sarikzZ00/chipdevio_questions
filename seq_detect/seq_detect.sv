// Prompt
// Given a stream of input bits, 
// pulse a 1 on the output (dout) whenever a b1010 sequence is detected on the input (din).

// When the reset-low signal (resetn) goes active, 
// all previously seen bits on the input are no longer considered when searching for b1010.

// Input and Output Signals
// clk - Clock signal
// resetn - Synchronous reset-low signal
// din - Input bits
// dout - 1 if a b1010 was detected, 0 otherwise
// Output signals during reset
// dout - 0 when resetn is active

module seq_detect (
    input clk,
    input resetn,
    input din,
    output logic dout

);

typedef enum  { 
    RESET,
    FIRST_1,
    FIRST_0,
    SEC_1,
    SEC_0
} STATE;


STATE state, state_next;

always_ff @(posedge clk) begin
    if (!resetn) begin
        state <= RESET;
    end
    else begin
        state <= state_next;
    end
end

always_comb begin
    case (state)
    RESET: begin
        dout = 0;
        state_next = din ? FIRST_1 : RESET;
    end
    FIRST_1: begin
        dout = 0;
        state_next = din ? FIRST_1 : FIRST_0;
    end
    FIRST_0: begin
        dout = 0;
        state_next = din ? SEC_1 : RESET;
    end
    SEC_1: begin
        dout = 0;
        state_next = din ? FIRST_1 : SEC_0;
    end
    SEC_0: begin
        dout = 1;
        state_next = din ? SEC_1 : RESET;
    end
    endcase
end

endmodule