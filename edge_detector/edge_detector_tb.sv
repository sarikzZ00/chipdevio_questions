module edge_detector_tb;

    logic clk;
    logic resetn;
    logic din;
    logic dout;

    // Instantiate the pulse_generator module
    edge_detector uut (
        .clk(clk),
        .resetn(resetn),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns period clock

    // File handle for writing signal values
    int file;

    // Initial setup
    initial begin
        // Open a file for writing
        file = $fopen("signal_values.txt", "w");

        // Write the header
        $fwrite(file, "Time (ns)\tclk\tresetn\tdin\tdout\n");
        $fwrite(file, "--------------------------------------\n");

        // Initialize signals
        clk = 0;
        resetn = 0;
        din = 0;

        // Apply reset
        #10;
        resetn = 1;

        // Test sequence
        #20 din = 1;
        #10 din = 0; // Pulse should appear on dout after this change

        #20 din = 1;
        #10 din = 0; // Pulse should appear on dout after this change

        #20 $finish;
    end

    // Monitor and write signals to file
    always @(posedge clk) begin
        $fwrite(file, "%0t\t%b\t%b\t%b\t%b\n", $time, clk, resetn, din, dout);
    end

    // Close the file at the end of the simulation
    final begin
        $fclose(file);
    end

endmodule
