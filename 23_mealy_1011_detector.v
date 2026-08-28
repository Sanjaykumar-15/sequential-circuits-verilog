// Designed by Sanjaykumar R

module mealy_1011_detector(
    input      clk,
    input      rst,
    input      din,
    output reg dout
);

    parameter S0 = 2'd0, S1 = 2'd1, S2 = 2'd2, S3 = 2'd3;
    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst)
    begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*)
    begin
        next_state = state;
        dout       = 1'b0;
        case (state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S1 : S2;
            S2: next_state = din ? S3 : S0;
            S3: begin
                    if (din) begin
                        next_state = S1;
                        dout       = 1'b1;
                    end else begin
                        next_state = S2;
                    end
                end
            default: next_state = S0;
        endcase
    end

endmodule

module tb_mealy_1011_detector;

reg  clk, rst, din;
wire dout;

mealy_1011_detector dut(
    .clk(clk),
    .rst(rst),
    .din(din),
    .dout(dout)
);

always #5 clk = ~clk;

initial
begin

    $dumpfile("mealy_1011_detector.vcd");
    $dumpvars(0, tb_mealy_1011_detector);

    $monitor("Time=%0t clk=%b rst=%b din=%b dout=%b", $time, clk, rst, din, dout);

    clk = 0; rst = 1; din = 0;
    #10 rst = 0;

    din = 1; #10;
    din = 0; #10;
    din = 1; #10;
    din = 1; #10;
    din = 0; #10;
    din = 1; #10;
    din = 1; #10;

    $finish;
end

endmodule
