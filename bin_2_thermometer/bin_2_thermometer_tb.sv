`timescale 1ns/1ps

module binary_to_thermometer_tb;

    // DUT signals
    logic [7:0] din;
    logic [255:0] dout;

    // Instantiate the DUT
    binary_to_thermometer dut (
        .din(din),
        .dout(dout)
    );

    // Test Procedure
    initial begin
        for (int i = 0; i < 256; i++) begin
            din = i;
            #5;
            $display("din = %3d -> dout = %b", din, dout[31:0]);
  
            if (dout != ((1 << (din + 1)) - 1)) begin
                $error("Mismatch at din = %d! Expected %b but got %b", din, (1 << (din + 1)) - 1, dout);
            end
        end

        $display("All tests completed.");
        $finish;
    end

endmodule
