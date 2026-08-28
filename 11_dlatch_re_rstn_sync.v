// Designed by Sanjaykumar R

module dff_re_rstn_sync (
    input  wire clk,
    input  wire rstn,
    input  wire d,
    output wire q
);
    wire clkn, d_eff, d_eff_n;
    wire Sm, Rm, qm, qmn;
    wire Ss, Rs, qn;

    not  g1  (clkn, clk);
    and  g2  (d_eff, d, rstn);
    not  g3  (d_eff_n, d_eff);

    nand g4  (Sm, d_eff,   clkn);
    nand g5  (Rm, d_eff_n, clkn);
    nand g6  (qm,  Sm, qmn);
    nand g7  (qmn, Rm, qm);

    nand g8  (Ss, qm,  clk);
    nand g9  (Rs, qmn, clk);
    nand g10 (q,  Ss, qn);
    nand g11 (qn, Rs, q);
endmodule

module tb;

reg clk;
reg rstn;
reg d;

wire q;

dff_re_rstn_sync uut (
    .clk(clk),
    .rstn(rstn),
    .d(d),
    .q(q)
);

initial begin

    $dumpfile("dff_re_rstn_sync.vcd");
    $dumpvars(0, tb);

    $monitor("Time=%0t | CLK=%b RST=%b D=%b | Q=%b",
             $time, clk, rstn, d, q);

    clk = 0;
    rstn = 0;
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

    rstn = 1;
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

    rstn = 0;

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
