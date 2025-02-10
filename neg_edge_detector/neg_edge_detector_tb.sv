module neg_edge_detector_tb;

    logic clk;
    logic resetn;
    logic din;
    logic dout;
    
    // Expected value for dout
    logic expected_dout;
    
    // File handle for writing signal values
    int file;

    // Instantiate the pulse_generator module
    neg_edge_detector uut (
        .clk(clk),
        .resetn(resetn),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period clock

    // Initial setup
    initial begin
        // Open a file for writing
        file = $fopen("signal_values.txt", "w");

        // Write the header
        $fwrite(file, "Time (ns)\tclk\tresetn\tdin\tdout\texpected_dout\n");
        $fwrite(file, "------------------------------------------------------\n");

        // Initialize signals
        clk = 0;
        resetn = 0;
        din = 0;
        expected_dout = 0;

        // Apply reset
        #10;
        resetn = 1;

        // Test sequence
        #20 din = 1; expected_dout = 0;
        #10 din = 0; expected_dout = 1; // Pulse should appear on dout after this change

        #20 din = 1; expected_dout = 0;
        #10 din = 0; expected_dout = 1; // Pulse should appear on dout after this change

        #20 $finish;
    end

    // Monitor and write signals to file
    always @(posedge clk) begin
        $fwrite(file, "%0t\t%b\t%b\t%b\t%b\t%b\n", $time, clk, resetn, din, dout, expected_dout);

        // Check for mismatches between dout and expected_dout
        if (dout !== expected_dout) begin
            $display("ERROR at time %0t: dout = %b, expected = %b", $time, dout, expected_dout);
        end
    end

    // Close the file at the end of the simulation
    final begin
        $fclose(file);
    end

endmodule
