module model #(parameter
  DATA_WIDTH = 16
) (
  input clk,
  input resetn,
  input din,
  output logic [DATA_WIDTH-1:0] dout
);

logic [DATA_WIDTH-1:0] shift_in;
    always_ff @(posedge clk) begin
        if (!resetn) begin
            shift_in <= 0;
        end else begin
            shift_in <= (shift_in << 1) + din; // Shift dout left and concatenate din
        end
    end

    assign dout = shift_in;


endmodule