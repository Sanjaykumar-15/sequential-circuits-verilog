// Designed by Sanjaykumar R

module johnson_counter #(
    parameter WIDTH = 4
) (
    input  wire clk,
    input  wire rst,
    output reg [WIDTH-1:0] q
);
    always @(posedge clk) begin
        if (rst)
            q <= {WIDTH{1'b0}};
        else
            q <= {q[WIDTH-2:0], ~q[WIDTH-1]};
    end
endmodule

module tb;

    parameter WIDTH = 4;

    reg clk;
    reg rst;
    wire [WIDTH-1:0] q;

    johnson_counter #(
        .WIDTH(WIDTH)
    ) uut (
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("Ring_Counter.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        clk = 1'b0;
        rst = 1'b1;

        #12;
        rst = 1'b0;

        #50;

        rst = 1'b1;
        #10;
        rst = 1'b0;

        #30;

        $finish;
    end

    initial begin
        $monitor("Time=%0t | clk=%b | rst=%b | q=%b",
                 $time, clk, rst, q);
    end

endmodule
