// Designed by Sanjaykumar R

module dff_re_rst_sync (
    input  wire clk,
    input  wire rst,
    input  wire d,
    output wire q
);
    wire clkn, rst_n, d_eff, d_eff_n;
    wire Sm, Rm, qm, qmn;
    wire Ss, Rs, qn;

    not  g1  (clkn, clk);
    not  g2  (rst_n, rst);
    and  g3  (d_eff, d, rst_n);
    not  g4  (d_eff_n, d_eff);

    nand g5  (Sm, d_eff,   clkn);
    nand g6  (Rm, d_eff_n, clkn);
    nand g7  (qm,  Sm, qmn);
    nand g8  (qmn, Rm, qm);

    nand g9  (Ss, qm,  clk);
    nand g10 (Rs, qmn, clk);
    nand g11 (q,  Ss, qn);
    nand g12 (qn, Rs, q);
endmodule

module tb;

reg clk;
reg rst;
reg d;

wire q;

dff_re_rst_sync uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

initial begin

    $dumpfile("dff_re_rst_sync.vcd");
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
