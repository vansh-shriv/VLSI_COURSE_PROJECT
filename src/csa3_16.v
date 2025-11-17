module csa3_16(
  input  [15:0] x,
  input  [15:0] y,
  input  [15:0] z,
  output [15:0] sum,
  output [15:0] carry_sh
);
  assign sum = x ^ y ^ z;
  assign carry_sh = ((x & y) | (y & z) | (x & z)) << 1;
endmodule
