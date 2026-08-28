// Designed by Sanjaykumar R

module dff_re_rst_async (
    input  wire clk,
    input  wire rst,
    input  wire d,
    output wire q
);
    wire clkn, rst_n, dn_m;
    wire nd_m, nr_m, Sm, Rm, qm, qmn;
    wire nd_s, nr_s, Ss, Rs, qn;

    not  g1  (clkn, clk);
    not  g2  (rst_n, rst);

    not  g3  (dn_m, d);
    nand g4  (nd_m, d,   clkn);
    or   g5  (Sm,   nd_m, rst);
    nand g6  (nr_m, dn_m, clkn);
    and  g7  (Rm,   rst_n, nr_m);
    nand g8  (qm,  Sm, qmn);
    nand g9  (qmn, Rm, qm);

    nand g10 (nd_s, qm,  clk);
    or   g11 (Ss,   nd_s, rst);
    nand g12 (nr_s, qmn, clk);
    and  g13 (Rs,   rst_n, nr_s);
    nand g14 (q,  Ss, qn);
    nand g15 (qn, Rs, q);
endmodule

module tb;

reg clk;
reg rst;
reg d;

wire q;

dff_re_rst_async uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

initial begin

    $dumpfile("dff_re_rst_async.vcd");
    $dumpvars(0, tb);

    $monitor("Time=%0t | CLK=%b RST=%b D=%b | Q=%b",
             $time, clk, rst, d, q);

    clk = 0;
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

    rst = 1;
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

    rst = 0;

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
