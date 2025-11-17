`timescale 1ns/1ps

module tb_multiplier_wallace;

    reg  [7:0] a, b;
    wire [15:0] product;

    // Instantiate DUT
    multiplier_wallace uut (
        .a(a),
        .b(b),
        .product(product)
    );

    integer i;

    initial begin
        $dumpfile("waves/multiplier_wallace.vcd");
        $dumpvars(0, tb_multiplier_wallace);

        // Test vectors
        a = 8'd0;   b = 8'd0;   #10;
        a = 8'd5;   b = 8'd7;   #10;
        a = 8'd10;  b = 8'd14;  #10;
        a = 8'd25;  b = 8'd3;   #10;
        a = 8'd55;  b = 8'd22;  #10;
        a = 8'd100; b = 8'd12;  #10;
        a = 8'd255; b = 8'd1;   #10;
        a = 8'd255; b = 8'd255; #10;

         // Random exhaustive-ish tests (not full 65536 but many)
        for (i = 0; i < 2000; i = i + 1) begin
            a = $random % 256;
            b = $random % 256;
            #1;
            if (product !== ((a+0)*(b+0))) begin
                $display("ERROR: a=%0d b=%0d product=%0d expected=%0d", a, b, product, ((a+0)*(b+0)));
                $finish;
            end
            #4;
        end

        $display("All random checks passed.");
        $finish;
    end

endmodule
