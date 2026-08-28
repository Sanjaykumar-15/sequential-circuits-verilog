// Designed by Sanjaykumar R

module sipo_shift_reg (
    input  wire clk,
    input  wire rst,
    input  wire serial_in,
    output wire [7:0] parallel_out
);

    reg [7:0] shreg;

    always @(posedge clk) begin
        if (rst)
            shreg <= 8'b0;
        else
            shreg <= {shreg[6:0], serial_in};
    end

    assign parallel_out = shreg;

endmodule

module tb;

    reg clk;
    reg rst;
    reg serial_in;
    wire [7:0] parallel_out;

    sipo_shift_reg uut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .parallel_out(parallel_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("SIPO_Shift_Register.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        clk = 0;
        rst = 1;
        serial_in = 0;

        #12;
        rst = 0;

        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;

        #20;

        rst = 1;
        #10;

        rst = 0;
        #20;

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | rst=%b | serial_in=%b | parallel_out=%b",
            $time, rst, serial_in, parallel_out
        );
    end

endmodule
