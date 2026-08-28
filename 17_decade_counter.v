// Designed by Sanjaykumar R

module decade_counter (
    input  wire clk,
    input  wire rst,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (rst)
            q <= 4'd0;
        else if (q == 4'd9)
            q <= 4'd0;
        else
            q <= q + 4'd1;
    end
endmodule

module tb;

    reg clk;
    reg rst;
    wire [3:0] q;

    decade_counter uut (
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("Decade_Counter.vcd");
        $dumpvars(0, tb);
    end

    initial begin

        clk = 1'b0;
        rst = 1'b1;

        #12;

        rst = 1'b0;

        #100;

        rst = 1'b1;

        #10;

        rst = 1'b0;

        #50;

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | clk=%b | rst=%b | q=%d | q(binary)=%b",
            $time,
            clk,
            rst,
            q,
            q
        );
    end

endmodule
