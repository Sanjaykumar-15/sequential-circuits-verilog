// Designed by Sanjaykumar R

module jk_ff(
    input      clk,
    input      rst,
    input      j,
    input      k,
    output reg q
);

    always @(posedge clk or posedge rst)
    begin
        if (rst)
            q <= 1'b0;
        else begin
            case ({j,k})
                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= ~q;
            endcase
        end
    end

endmodule

module tb_jk_ff;

reg  clk, rst, j, k;
wire q;

jk_ff dut(
    .clk(clk),
    .rst(rst),
    .j(j),
    .k(k),
    .q(q)
);

always #5 clk = ~clk;

initial
begin

    $dumpfile("jk_ff.vcd");
    $dumpvars(0, tb_jk_ff);

    $monitor("Time=%0t clk=%b rst=%b j=%b k=%b q=%b", $time, clk, rst, j, k, q);

    clk = 0; rst = 1; j = 0; k = 0;
    #10 rst = 0;

    j = 0; k = 0; #10;
    j = 1; k = 0; #10;
    j = 0; k = 1; #10;
    j = 1; k = 1; #10;
    j = 1; k = 1; #10;

    $finish;
end

endmodule
