// 8-bit Array Multiplier (Basic Version)
module multiplier_array (
    input  [7:0] a,
    input  [7:0] b,
    output [15:0] product
);

    wire [7:0] pp[7:0]; // partial products

    genvar i;
    generate
        for(i = 0; i < 8; i = i + 1) begin
            assign pp[i] = b[i] ? a : 8'b0;
        end
    endgenerate

    // Simple addition of partial products (non-optimized)
    assign product = {8'b0, pp[0]} +
                     {7'b0, pp[1], 1'b0} +
                     {6'b0, pp[2], 2'b0} +
                     {5'b0, pp[3], 3'b0} +
                     {4'b0, pp[4], 4'b0} +
                     {3'b0, pp[5], 5'b0} +
                     {2'b0, pp[6], 6'b0} +
                     {1'b0, pp[7], 7'b0};

endmodule
