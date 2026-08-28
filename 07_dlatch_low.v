// Designed by Sanjaykumar R

module dlatch_high (
    input  wire d,
    input  wire clk,
    output wire q
);
    wire Dn, S, R, Qn;

    not  g1 (Dn, d);
    nand g2 (S, d,  clk);
    nand g3 (R, Dn, clk);
    nand g4 (q,  S, Qn);
    nand g5 (Qn, R, q);
endmodule

module tb;

reg clk;
reg d;

wire q;

dlatch_high uut (
    .clk(clk),
    .d(d),
    .q(q)
);

initial begin

    $dumpfile("dlatch_high.vcd");
    $dumpvars(0, tb);

    $monitor("Time=%0t | CLK=%b | D=%b | Q=%b",
             $time, clk, d, q);

    clk = 0;

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

    d   = 0;

    #10;

    clk = 1;
    #10;

    clk = 0;
    #10;

    d = 1;
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
    #5;

    clk = 1;
    #5;

    #10;

    $finish;

end

endmodule
