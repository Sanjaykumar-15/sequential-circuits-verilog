// Designed by Sanjaykumar R

module t_ff(
    input      clk,
    input      rst,
    input      t,
    output reg q
);

    always @(posedge clk or posedge rst)
    begin
        if (rst)
            q <= 1'b0;
        else if (t)
            q <= ~q;
        else
            q <= q;
    end

endmodule

module tb_t_ff;

reg  clk, rst, t;
wire q;

t_ff dut(
    .clk(clk),
    .rst(rst),
    .t(t),
    .q(q)
);

always #5 clk = ~clk;

initial
begin

    $dumpfile("t_ff.vcd");
    $dumpvars(0, tb_t_ff);

    $monitor("Time=%0t clk=%b rst=%b t=%b q=%b", $time, clk, rst, t, q);

    clk = 0; rst = 1; t = 0;
    #10 rst = 0;

    t = 0; #10;
    t = 1; #10;
    t = 1; #10;
    t = 0; #10;
    t = 1; #10;

    $finish;
end

endmodule
