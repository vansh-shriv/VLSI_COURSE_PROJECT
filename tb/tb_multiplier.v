`timescale 1ns/1ps

module tb_multiplier_array;

    reg [7:0] a, b;
    wire [15:0] product;

    multiplier_array DUT (.a(a), .b(b), .product(product));

    initial begin
        $dumpfile("waves/multiplier_array.vcd");
        $dumpvars(0, tb_multiplier_array);

        // Testcases
        a = 8'd5;  b = 8'd10;  #10;
        a = 8'd15; b = 8'd15;  #10;
        a = 8'd0;  b = 8'd200; #10;
        a = 8'd255; b = 8'd255; #10;

        $finish;
    end

endmodule
