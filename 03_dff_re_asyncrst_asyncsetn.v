// Designed by Sanjaykumar R

module dff_re_asyncrst_asyncsetn (
    input  wire clk,
    input  wire rst,
    input  wire setn,
    input  wire d,
    output reg q
);

    always @(posedge clk or posedge rst or negedge setn) begin
        if (rst)
            q <= 1'b0;
        else if (!setn)
            q <= 1'b1;
        else
            q <= d;
    end

endmodule

module tb;

reg clk;
reg setn;
reg rst;
reg d;

wire q;

dff_re_asyncrst_asyncsetn uut (
    .clk(clk),
    .setn(setn),
    .rst(rst),
    .d(d),
    .q(q)
);

initial begin

    $dumpfile("dff_re_asyncrst_asyncsetn.vcd");
    $dumpvars(0, tb);

    $monitor("Time=%0t | CLK=%b SETN=%b RST=%b D=%b | Q=%b",
             $time, clk, setn, rst, d, q);

    clk = 0;
    setn = 0;
    rst = 0;
    d   = 0;

    #10;

    d = 1;
    #5;
    clk = 1;
    #5;

    clk = 0;
    #10;

    d = 0;
    #5;
    clk = 1;
    #5;

    clk = 0;
    #10;

    d = 1;
    #5;
    clk = 1;
    #5;

    clk = 0;
    #10;

    d = 0;
    setn = 1;

    #5;

    #5;

    setn = 0;

    #10;

    d = 0;
    #5;
    clk = 1;
    #5;

    clk = 0;
    #10;

    rst = 1;

    #5;

    #5;

    rst = 0;

    #10;

    d = 1;
    #5;
    clk = 1;
    #5;

    clk = 0;
    #10;

    setn = 1;
    rst = 1;

    #10;

    rst = 0;

    #10;

    setn = 0;

    #10;

    d = 0;
    #5;
    clk = 1;
    #5;

    clk = 0;
    #10;

    d = 1;
    #5;
    clk = 1;
    #5;

    #10;

    $finish;

end

endmodule
