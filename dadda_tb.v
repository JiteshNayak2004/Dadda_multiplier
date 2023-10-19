module testbench;
  reg [3:0] A;
  reg [3:0] B;
  wire [7:0] product;

  // Instantiate the Dadda Multiplier
  dadda_multiplier dut (
    .A(A),
    .B(B),
    .product(product)
  );

  // Generate clock signal
  reg clock = 0;
  always #5 clock = ~clock;

  // Test input vectors
  initial begin
    $dumpfile("sim.vcd"); // Specify the VCD file name
    $dumpvars(0, testbench); // Dump all variables in the testbench
    $monitor("A=%b, B=%b, Product=%b", A, B, product);
    A = 4'b0010; // Change input values as needed
    B = 4'b0011;

    // Simulate for some time
    #50 $finish;
  end

  // Clock generation
  always #1 clock = ~clock;

  // Apply inputs
  always @(posedge clock) begin
    // Change input values as needed
    A <= 4'b0101;
    B <= 4'b1100;
  end

endmodule
