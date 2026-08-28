// Designed by Sanjaykumar R

module jk_ff (
    input  wire clk,
    input  wire rst,
    input  wire j,
    input  wire k,
    output reg  q
);
    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else begin
            case ({j, k})
                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= ~q;
            endcase
        end
    end
endmodule

module gray_counter_3bit_jk (
    input  wire clk,
    input  wire rst,
    output wire [2:0] q
);
    wire Q0, Q1, Q2;
    wire J0, K0, J1, K1, J2, K2;

    assign J0 = ~(Q2 ^ Q1);
    assign K0 =  (Q2 ^ Q1);
    assign J1 = ~Q2 & Q0;
    assign K1 =  Q2 & Q0;
    assign J2 =  Q1 & ~Q0;
    assign K2 = ~Q1 & ~Q0;

    jk_ff FF0 (.clk(clk), .rst(rst), .j(J0), .k(K0), .q(Q0));
    jk_ff FF1 (.clk(clk), .rst(rst), .j(J1), .k(K1), .q(Q1));
    jk_ff FF2 (.clk(clk), .rst(rst), .j(J2), .k(K2), .q(Q2));

    assign q = {Q2, Q1, Q0};
endmodule

module tb;

    reg clk;
    reg rst;

    wire [2:0] q;

    gray_counter_3bit_jk uut (
        .clk(clk),
        .rst(rst),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("Gray_Counter_JK.vcd");
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

        #80;

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | clk=%b | rst=%b | q=%b",
            $time,
            clk,
            rst,
            q
        );
    end

endmodule
