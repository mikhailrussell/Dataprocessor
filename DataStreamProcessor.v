  //--------------------------------------------------------------
  // Module: DataStreamProcessor
  // Description: This module processes a data stream and replaces
  //              any zero data points with the average of the
  //              neighboring values.
  //
  // Author: Mikhail Russell RSSMIK001
  // Date: 14 July 2023
  //--------------------------------------------------------------

module DataStreamProcessor (
  input wire clk,       // Clock input
  input wire reset,     // Reset input
  input wire [63:0] data_in,    // Serial data input
  output wire [63:0] data_out    // Output bus
);

  reg [63:0] output_reg;   // Output register
  reg [63:0] prev_data;   // Previous data point
  reg [63:0] curr_data;   // Current data point
  reg [63:0] next_data;   // Next data point

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      output_reg <= 64'h0000000000000000;
      prev_data <= 64'h0000000000000000;
      curr_data <= 64'h0000000000000000;
      next_data <= 64'h0000000000000000;
    end else begin
      prev_data <= curr_data;
      curr_data <= next_data;
      next_data <= data_in;

      if (curr_data == 64'h0000000000000000) begin
        // Replace zero by averaging neighboring data points
        output_reg <= (prev_data + curr_data + next_data) >> 1;
      end else begin
        output_reg <= curr_data;
      end
    end
  end

  assign data_out = output_reg;

endmodule