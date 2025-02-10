module reversing_bits_tb;

    // Parameter for the width of the data
    localparam DATA_WIDTH = 32;

    // Testbench signals
    logic [DATA_WIDTH-1:0] din;
    logic [DATA_WIDTH-1:0] dout;

    // File handle
    integer file;

    // Instantiate the reversing_bits module
    reversing_bits #(.DATA_WIDTH(DATA_WIDTH)) uut (
        .din(din),
        .dout(dout)
    );

    // Task to reverse bits for comparison
    function [DATA_WIDTH-1:0] reverse_bits(input [DATA_WIDTH-1:0] data);
        logic [DATA_WIDTH-1:0] reversed_data;
        for (int i = 0; i < DATA_WIDTH; i++) begin
            reversed_data[i] = data[DATA_WIDTH-1-i];
        end
        return reversed_data;
    endfunction

    // Initial block to apply test vectors and write to file
    initial begin
        // Open the file
        file = $fopen("test_results.txt", "w");
        if (file == 0) begin
            $display("Failed to open file for writing");
            $finish;
        end

        // Write header to file
        $fwrite(file, "Test Results:\n");
        $fwrite(file, "=============================\n");
        $fwrite(file, "din (binary)                      dout (binary)                     expected (binary)\n");
        $fwrite(file, "=============================\n");

        // Test vector 1
        din = 32'b10100101101001011010010110100101; // 0xA5A5A5A5 in hex
        #10;
        $fwrite(file, "%b   %b   %b\n", din, dout, reverse_bits(din));
        assert(dout == reverse_bits(din)) else $error("Test vector 1 failed: din = %b, dout = %b, expected = %b", din, dout, reverse_bits(din));

        // Test vector 2
        din = 32'b00010010001101000101011001111000; // 0x12345678 in hex
        #10;
        $fwrite(file, "%b   %b   %b\n", din, dout, reverse_bits(din));
        assert(dout == reverse_bits(din)) else $error("Test vector 2 failed: din = %b, dout = %b, expected = %b", din, dout, reverse_bits(din));

        // Test vector 3
        din = 32'b11111111111111111111111111111111; // 0xFFFFFFFF in hex
        #10;
        $fwrite(file, "%b   %b   %b\n", din, dout, reverse_bits(din));
        assert(dout == reverse_bits(din)) else $error("Test vector 3 failed: din = %b, dout = %b, expected = %b", din, dout, reverse_bits(din));

        // Test vector 4
        din = 32'b00000000000000000000000000000000; // 0x00000000 in hex
        #10;
        $fwrite(file, "%b   %b   %b\n", din, dout, reverse_bits(din));
        assert(dout == reverse_bits(din)) else $error("Test vector 4 failed: din = %b, dout = %b, expected = %b", din, dout, reverse_bits(din));

        // Test vector 5
        din = 32'b10000000000000000000000000000001; // 0x80000001 in hex
        #10;
        $fwrite(file, "%b   %b   %b\n", din, dout, reverse_bits(din));
        assert(dout == reverse_bits(din)) else $error("Test vector 5 failed: din = %b, dout = %b, expected = %b", din, dout, reverse_bits(din));

        $fwrite(file, "All tests passed.\n");
        $display("All tests passed.");

        // Close the file
        $fclose(file);
        $finish;
    end

endmodule
