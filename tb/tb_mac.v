`timescale 1ns/1ps

module tb_mac;

    reg  [7:0]  a, b;
    reg  [15:0] acc;
    wire [15:0] mac_out;

    integer i;

    // Instantiate MAC Unit
    mac_unit DUT (
        .a(a),
        .b(b),
        .acc(acc),
        .mac_out(mac_out)
    );

    initial begin
        $dumpfile("waves/mac_unit.vcd");
        $dumpvars(0, tb_mac);

        // Directed Tests
        a = 8'd5; b = 8'd10; acc = 16'd20; #10;
        a = 8'd15; b = 8'd3; acc = 16'd7;   #10;
        a = 8'd255; b = 8'd1; acc = 16'd0;  #10;
        a = 8'd100; b = 8'd2; acc = 16'd50; #10;

        // Random Tests
        for (i = 0; i < 2000; i = i + 1) begin
            a   = $random % 256;
            b   = $random % 256;
            acc = $random % 65536;
            #1;
            if (mac_out !== (a * b + acc)) begin
                $display("ERROR: a=%0d b=%0d acc=%0d mac_out=%0d expected=%0d",
                         a, b, acc, mac_out, (a*b + acc));
                $finish;
            end
            #4;
        end

        $display("All MAC tests passed!");
        #100 $finish;
    end

endmodule
