// Designed by Sanjaykumar R

module dff_ne_rst_async (
    input  wire clk,
    input  wire rst,
    input  wire d,
    output wire q
);

wire clkn;
wire rst_n;

wire dn_m;
wire nd_m;
wire nr_m;
wire Sm;
wire Rm;
wire qm;
wire qmn;

wire nd_s;
wire nr_s;
wire Ss;
wire Rs;
wire qn;

not g1 (clkn, clk);
not g2 (rst_n, rst);

not  g3  (dn_m, d);

nand g4  (nd_m, d, clk);
or   g5  (Sm, nd_m, rst);

nand g6  (nr_m, dn_m, clk);
and  g7  (Rm, rst_n, nr_m);

nand g8  (qm,  Sm, qmn);
nand g9  (qmn, Rm, qm);

nand g10 (nd_s, qm, clkn);
or   g11 (Ss, nd_s, rst);

nand g12 (nr_s, qmn, clkn);
and  g13 (Rs, rst_n, nr_s);

nand g14 (q, Ss, qn);
nand g15 (qn, Rs, q);

endmodule

module tb;

reg clk;
reg rst;
reg d;

wire q;

dff_ne_rst_async uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

initial begin

    $dumpfile("dff_ne_rst_async.vcd");
    $dumpvars(0, tb);

    clk = 0;
    rst = 0;
    d   = 0;

    #5  d = 1;

    #5  clk = 1;

    #5  clk = 0;

    #5  d = 0;

    #5  clk = 1;

    #5  clk = 0;

    #5  d = 1;

    #5  clk = 1;

    #5  clk = 0;

    #5  rst = 1;

    #5;

    rst = 0;

    #5 d = 1;

    #5 clk = 1;

    #5 clk = 0;

    #10;

    $finish;

end

endmodule
