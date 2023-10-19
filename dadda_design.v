module dadda_multiplier (
  input wire [3:0] A,
  input wire [3:0] B,
  output wire [7:0] product
);

  wire [7:0] pp[3:0][3:0];
  wire [7:0] gi[3:0][3:0];
  wire [7:0] go[3:0][3:0];
  wire [7:0] pa[3:0][3:0];
  wire [7:0] go_prev[3:0][3:0];
  
  // Generate partial products using bitwise AND operations
  genvar i, j;
  generate
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        assign pp[i][j] = A[i] & B[j];
      end
    end
  endgenerate

  // Generate Gi and Go signals
  generate
    for (i = 0; i < 3; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        assign gi[i][j] = (pp[i][j] & pp[i+1][j]) | (go[i][j] & go_prev[i][j]);
        assign go[i+1][j] = (pp[i][j] | pp[i+1][j]) & go[i][j];
      end
    end
  endgenerate

  // Accumulate the partial products
  generate
    for (i = 0; i < 8; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        if (i < 4) begin
          assign pa[i][j] = pp[i][j];
        end else begin
          assign pa[i][j] = pp[i-4][j] << (i - 4);
        end
      end
    end
  endgenerate

  // Generate the final product
  always @* begin
    product = pa[0][0] + pa[0][1] + pa[0][2] + pa[0][3] + pa[1][0] + pa[1][1] + pa[1][2] + pa[1][3];
  end

endmodule
