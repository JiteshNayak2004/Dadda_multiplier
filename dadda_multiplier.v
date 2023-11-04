module dadda_multiplier(
  input wire [3:0] a,  // 4-bit input
  input wire [3:0] b,  // 4-bit input
  output wire [7:0] result  // 8-bit output
);

  wire [7:0] partial_products [3:0];
  wire [3:0] row0_parity, row1_parity, row2_parity;
  wire [2:0] col0_parity, col1_parity, col2_parity;
  
  // Generate partial products
  assign partial_products[0] = {4'b0, a} & {b[0], 4'b0};
  assign partial_products[1] = {3'b0, a} & {b[1], 3'b0};
  assign partial_products[2] = {2'b0, a} & {b[2], 2'b0};
  assign partial_products[3] = {1'b0, a} & {b[3], 1'b0};

  // Calculate row and column parities
  assign row0_parity = partial_products[0][0] ^ partial_products[1][0] ^ partial_products[2][0] ^ partial_products[3][0];
  assign row1_parity = partial_products[0][1] ^ partial_products[1][1] ^ partial_products[2][1] ^ partial_products[3][1];
  assign row2_parity = partial_products[0][2] ^ partial_products[1][2] ^ partial_products[2][2] ^ partial_products[3][2];
  
  assign col0_parity = partial_products[0][0] ^ partial_products[0][1] ^ partial_products[0][2] ^ partial_products[0][3];
  assign col1_parity = partial_products[1][0] ^ partial_products[1][1] ^ partial_products[1][2] ^ partial_products[1][3];
  assign col2_parity = partial_products[2][0] ^ partial_products[2][1] ^ partial_products[2][2] ^ partial_products[2][3];
  
  // Generate the final output
  assign result[0] = partial_products[0][0];
  assign result[1] = partial_products[0][1] ^ row0_parity;
  assign result[2] = partial_products[0][2] ^ row0_parity ^ col0_parity;
  assign result[3] = partial_products[0][3] ^ col0_parity;
  assign result[4] = partial_products[1][0];
  assign result[5] = partial_products[1][1] ^ row1_parity;
  assign result[6] = partial_products[1][2] ^ row1_parity ^ col1_parity;
  assign result[7] = partial_products[1][3] ^ col1_parity;

endmodule

