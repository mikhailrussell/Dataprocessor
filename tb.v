module DataStreamProcessor_TB;
  reg clk;
  reg reset;
  reg [63:0] data_in;
  wire [63:0] data_out;

  // Instantiate the module under test
  DataStreamProcessor dut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generator
  always #5 clk = ~clk;

  initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    data_in = 0;

    // Apply reset
    #10 reset = 0;

    // Test case 1: Zero data input
    #10 data_in = 1000;

    // Test case 2: Non-zero data input
    #10 data_in = 5000; // Non-zero data

    // Test case 3: Zero data with neighboring values for averaging
    #10 data_in = 0;

    // Test case 4: Zero data at the beginning and end
    #10 data_in = 3000;
    #10 data_in = 4000; // Non-zero data
    #10 data_in = 0;
    #10 data_in = 5000;

    // Add more test cases as needed


    // End simulation
    #100 $finish;
  end
endmodule