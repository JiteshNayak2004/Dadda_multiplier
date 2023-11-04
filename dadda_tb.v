module testbench;
  reg [3:0] A;
  reg [3:0] B;
  wire [7:0] product;
  integer test_count;

  // Instantiate the Dadda Multiplier
  dadda_multiplier dut (
    .A(A),
    .B(B),
    .product(product)
  );

  // Clock generation
  reg clock = 0;
  always #5 clock = ~clock;

  // Testbench stimulus
  initial begin
    $dumpfile("sim.vcd"); // Specify the VCD file name
    $dumpvars(0, testbench); // Dump all variables in the testbench

    test_count = 16; // You can change this to the desired number of test cases

    repeat (test_count) begin
      A = $random;
      B = $random;
      #10; // Allow some time for the signals to stabilize
      $display("Test case %0d: A = %4h, B = %4h, Product = %8h", test_count, A, B, product);
    end

    $finish;
  end
endmodule

