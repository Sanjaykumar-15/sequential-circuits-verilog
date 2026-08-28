// Designed by Sanjaykumar R

module dff_asyncset_asyncrst (
    input  wire clk,
    input  wire set,
    input  wire rst,
    input  wire d,
    output reg  q
);

    always @(posedge clk or posedge set or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else if (set)
            q <= 1'b1;
        else
            q <= d;
    end

endmodule

module tb;

reg clk;
reg set;
reg rst;
reg d;

wire q;

dff_asyncset_asyncrst uut (
    .clk(clk),
    .set(set),
    .rst(rst),
    .d(d),
    .q(q)
);

initial begin

    $dumpfile("dff_asyncset_asyncrst.vcd");
    $dumpvars(0, tb);

    $monitor("Time=%0t | CLK=%b SET=%b RST=%b D=%b | Q=%b",
             $time, clk, set, rst, d, q);

    clk = 0;
    set = 0;
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
    set = 1;

    #5;

    #5;

    set = 0;

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

    set = 1;
    rst = 1;

    #10;

    rst = 0;

    #10;

    set = 0;

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
