// Designed by Sanjaykumar R

module updown_counter_4bit(
    input            clk,
    input            rst,
    input            up_down,
    output reg [3:0] q
);

    always @(posedge clk or posedge rst)
    begin
        if (rst)
            q <= 4'b0000;
        else if (up_down)
            q <= q + 1'b1;
        else
            q <= q - 1'b1;
    end

endmodule

module tb_updown_counter_4bit;

reg        clk, rst, up_down;
wire [3:0] q;

updown_counter_4bit dut(
    .clk(clk),
    .rst(rst),
    .up_down(up_down),
    .q(q)
);

always #5 clk = ~clk;

initial
begin

    $dumpfile("updown_counter_4bit.vcd");
    $dumpvars(0, tb_updown_counter_4bit);

    $monitor("Time=%0t clk=%b rst=%b up_down=%b q=%d", $time, clk, rst, up_down, q);

    clk = 0; rst = 1; up_down = 1;
    #10 rst = 0;

    up_down = 1;
    #100;

    up_down = 0;
    #100;

    $finish;
end

endmodule
