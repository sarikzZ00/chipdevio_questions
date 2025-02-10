// Build a circuit that generates a Gray code sequence starting from 0 on the output (dout).

// Gray code is an ordering of binary numbers such that two successive values only have one bit difference between them. For example, a Gray code sequence for a two bit value could be:

// b00
// b01
// b11
// b10

// The Gray code sequence should use the standard encoding. In the standard encoding the least significant bit follows a repetitive pattern of 2 on, 2 off ( ... 11001100 ... ); the next digit a pattern of 4 on, 4 off ( ... 1111000011110000 ... ); the nth least significant bit a pattern of 2n on 2n off.

// When the reset-low signal (resetn) goes to 0, the Gray code sequence should restart from 0.

// Input and Output Signals
// clk - Clock signal
// resetn - Synchronous reset-low signal
// out - Gray code counter value
// Output signals during reset
// out - 0 when resetn is active

module gray_code #(parameter
  DATA_WIDTH = 4
) (
  input clk,
  input resetn,
  output logic [DATA_WIDTH-1:0] out
);
logic [DATA_WIDTH-1:0] binary_counter;
logic [DATA_WIDTH-1:0] temp;
logic [DATA_WIDTH-1:0] next_binary_counter;
always_ff @(posedge clk) begin
  if (!resetn) begin
    out <= 0;
    binary_counter <= 0;
  end
  else begin
    //out <= temp;
    binary_counter <= next_binary_counter;
    out <= temp;
  end
end

always_comb begin
  //logic [DATA_WIDTH-1:0] next_binary_counter;
  next_binary_counter = binary_counter + 1;
  for (int i = DATA_WIDTH - 1; i >= 0; i--) begin
    if (i == DATA_WIDTH-1) begin
      temp[DATA_WIDTH-1] = next_binary_counter[DATA_WIDTH-1];
    end
    else begin
      temp[i] = next_binary_counter[i+1] ^ next_binary_counter[i];
    end
  end
end

endmodule