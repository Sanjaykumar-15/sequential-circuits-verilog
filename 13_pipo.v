// Designed by Sanjaykumar R

module pipo_reg (
    input  wire clk,
    input  wire rst,
    input  wire load,
    input  wire [7:0] parallel_in,
    output reg [7:0] parallel_out
);

    always @(posedge clk) begin
        if (rst)
            parallel_out <= 8'b0;
        else if (load)
            parallel_out <= parallel_in;
    end

endmodule

module tb;

    reg clk;
    reg rst;
    reg load;
    reg [7:0] parallel_in;
    wire [7:0] parallel_out;

    pipo_reg uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .parallel_in(parallel_in),
        .parallel_out(parallel_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("PIPO_Register.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        clk = 0;
        rst = 1;
        load = 0;
        parallel_in = 8'b0;

        #12;
        rst = 0;

        parallel_in = 8'b10110011;
        load = 1;

        #10;

        load = 0;

        #30;

        parallel_in = 8'b11001100;
        load = 1;

        #10;

        load = 0;

        #30;

        rst = 1;
        #10;

        rst = 0;
        #20;

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | rst=%b | load=%b | parallel_in=%b | parallel_out=%b",
            $time, rst, load, parallel_in, parallel_out
        );
    end

endmodule
