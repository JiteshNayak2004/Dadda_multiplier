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

  // Test all possible input vectors
  initial begin
    $dumpfile("sim.vcd"); // Specify the VCD file name
    $dumpvars(0, testbench); // Dump all variables in the testbench

    // Loop through all possible input combinations
    for (A = 0; A < 16; A = A + 1) begin
      for (B = 0; B < 16; B = B + 1) begin
        $monitor("A=%b, B=%b, Product=%b", A, B, product);
        #50; // Simulate for 50 time units
      end
    end

    $finish;
  end

  // Clock generation
  always #1 clock = ~clock;

endmodule
