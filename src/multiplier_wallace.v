// 8x8 Wallace-like multiplier using carry-save adder (CSA) tree
module multiplier_wallace(
    input  [7:0] a,
    input  [7:0] b,
    output [15:0] product
);

  // 16-bit shifted partial products
  wire [15:0] pp_shift [7:0];
  genvar k;
  generate
    for (k = 0; k < 8; k = k + 1) begin : gen_pp_shifts
      // extend a into 16 bits then shift by k
      assign pp_shift[k] = b[k] ? ({8'b0, a} << k) : 16'b0;
    end
  endgenerate

  // Stage 1: reduce groups of three partial products
  wire [15:0] s1, c1, s2, c2, s3, c3;
  csa3_16 u1 (pp_shift[0], pp_shift[1], pp_shift[2], s1, c1);
  csa3_16 u2 (pp_shift[3], pp_shift[4], pp_shift[5], s2, c2);
  csa3_16 u3 (pp_shift[6], pp_shift[7], 16'b0,          s3, c3);

  // Stage 2: reduce the stage-1 sums and the stage-1 carries
  wire [15:0] s4, c4, s5, c5;
  csa3_16 u4 (s1, s2, s3, s4, c4);
  csa3_16 u5 (c1, c2, c3, s5, c5); // c1/c2/c3 already include their left-shift

  // Stage 3: reduce the two resulting sums
  wire [15:0] s6, c6;
  csa3_16 u6 (s4, s5, 16'b0, s6, c6);

  // Final: add remaining operands (s6 + c4 + c5 + c6). All carries produced by CSA are left-shifted.
  assign product = s6 + c4 + c5 + c6;

endmodule
