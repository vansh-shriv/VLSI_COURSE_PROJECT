`timescale 1ns/1ps
module mac_unit (
    input  [7:0]  a,
    input  [7:0]  b,
    input  [15:0] acc,
    output [15:0] mac_out
);

    wire [15:0] product;

    // Use your Wallace multiplier
    multiplier_wallace mul (
        .a(a),
        .b(b),
        .product(product)
    );

    assign mac_out = product + acc;

endmodule

// This is intentionally simple — because for now we focus on functional comparison.
// Later we will add CLA adder + pipelining enhancements.