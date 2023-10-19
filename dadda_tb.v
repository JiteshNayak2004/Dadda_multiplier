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

  // Test random input vectors
  initial begin
    $dumpfile("sim.vcd"); // Specify the VCD file name
    $dumpvars(0, testbench); // Dump all variables in the testbench

    // Simulate for a number of random test cases
    integer num_test_cases = 100; // You can change this to the desired number of test cases

    repeat (num_test_cases) begin
      A = $random;
      B = $random;

      $monitor("A=%b, B=%b, Product=%b", A, B, product);
      #50; // Simulate for 50 time units
    end

    $finish;
  end

  // Clock generation
  always #1 clock = ~clock;

endmodule
