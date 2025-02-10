//Prompt

// Design a multi-bit First In First Out (FIFO) circuit.  The FIFO includes two entries of size DATA_WIDTH and requires zero output latency. 

// Upon assertion of resetn (active-low), the FIFO is reset to zero and the empty signal is set to logic high to indicate the FIFO is empty.  
//Once resetn is unpressed, the operation starts.  The FIFO has a two-entry bank of flip-flops that can be written to by using inputs din (data in) and wr (write-enable).  
//If wr is set to logic low, the input din does not get written to the FIFO.

// As the FIFO is being written to, its output port dout should imediatelly reflect the first-in data, 
//i.e., there should be no latency between inputs and outputs.  
//Once all entries are written to, the FIFO should output full = 1 in order to indicate it is full.  
//Writing to a full FIFO is a valid operation and the output full must be set to one.

// Important
// There are at least three possible states in this design:  (1) Empty;  (2) Intermediate;  (3) Full.  
//Whenever the FIFO is reset, it transitions to state (1). 
// As the entries are updated, the state switches from (1) to (2), 
//and finally from (2) to (3), once completely filled.  
//Use a mux to direct the intermediate stages of the FIFO to the output port dout to achieve a low latency design.

// Input and Output Signals

//     clk - Clock signal
//     resetn - Active-low, reset signal
//     din - FIFO input data
//     wr - Active-high, write signal
//     dout - FIFO output data
//     full - Full FIFO indicator
//     empty - Empty FIFO indicator

// Output signals during reset

//     dout - 0
//     full - 0
//     empty - 1




module multi_bit_fifo #(parameter DATA_WIDTH = 8) (
    input clk,
    input resetn,
    input [DATA_WIDTH-1:0] din,
    input wr,
    output logic [DATA_WIDTH-1:0] dout,
    output logic full,
    output logic empty
);






endmodule