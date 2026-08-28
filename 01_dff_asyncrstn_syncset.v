// Designed by Sanjaykumar R

module dff_asyncrstn_syncset (
    input  wire clk,
    input  wire rstn,
    input  wire set,
    input  wire d,
    output reg  q
);

    always @(posedge clk or negedge rstn) begin
        if (!rstn)
            q <= 1'b0;
        else
            q <= d | set;
    end

endmodule

module tb;

reg clk;
reg set;
reg rstn;
reg d;

wire q;

dff_asyncrstn_syncset uut (
    .clk(clk),
    .set(set),
    .rstn(rstn),
    .d(d),
    .q(q)
);

initial begin

    $dumpfile("dff_asyncrstn_syncset.vcd");
    $dumpvars(0, tb);

    $monitor("Time=%0t | CLK=%b SET=%b RSTN=%b D=%b | Q=%b",
             $time, clk, set, rstn, d, q);

    clk  = 0;
    set  = 0;
    rstn = 0;
    d    = 0;

    #10;

    rstn = 1;

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

    set = 1;
    d   = 0;

    #10;

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

    set = 0;

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

    rstn = 0;

    #5;

    #10;

    d = 1;

    #5;
    clk = 1;

    #5;

    clk = 0;

    #10;

    rstn = 1;

    #10;

    #5;
    clk = 1;

    #5;

    clk = 0;

    #10;

    d   = 0;
    set = 0;

    #5;
    clk = 1;

    #5;

    clk = 0;

    #10;

    set = 1;

    #10;

    clk = 1;

    #5;

    clk = 0;

    #10;

    set  = 1;
    rstn = 0;

    #10;

    clk = 1;

    #5;

    clk = 0;

    #10;

    rstn = 1;

    #10;

    clk = 1;

    #5;

    clk = 0;

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
