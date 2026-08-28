// Designed by Sanjaykumar R

module traffic_controller #(
    parameter GREEN_TIME  = 10,
    parameter YELLOW_TIME = 3
) (
    input  wire clk,
    input  wire rst,
    output reg  ns_red, ns_yellow, ns_green,
    output reg  ew_red, ew_yellow, ew_green
);
    localparam S_NS_GREEN  = 2'd0,
               S_NS_YELLOW = 2'd1,
               S_EW_GREEN  = 2'd2,
               S_EW_YELLOW = 2'd3;

    reg [1:0] state, next_state;
    reg [$clog2(GREEN_TIME):0] timer;
    wire timer_done_green  = (timer == GREEN_TIME  - 1);
    wire timer_done_yellow = (timer == YELLOW_TIME - 1);

    always @(posedge clk) begin
        if (rst) state <= S_NS_GREEN;
        else     state <= next_state;
    end

    always @(posedge clk) begin
        if (rst)
            timer <= 0;
        else if (state != next_state)
            timer <= 0;
        else
            timer <= timer + 1;
    end

    always @(*) begin
        next_state = state;
        case (state)
            S_NS_GREEN:  if (timer_done_green)  next_state = S_NS_YELLOW;
            S_NS_YELLOW: if (timer_done_yellow) next_state = S_EW_GREEN;
            S_EW_GREEN:  if (timer_done_green)  next_state = S_EW_YELLOW;
            S_EW_YELLOW: if (timer_done_yellow) next_state = S_NS_GREEN;
            default:     next_state = S_NS_GREEN;
        endcase
    end

    always @(*) begin
        {ns_red, ns_yellow, ns_green} = 3'b100;
        {ew_red, ew_yellow, ew_green} = 3'b100;
        case (state)
            S_NS_GREEN:  {ns_red, ns_yellow, ns_green} = 3'b001;
            S_NS_YELLOW: {ns_red, ns_yellow, ns_green} = 3'b010;
            S_EW_GREEN:  {ew_red, ew_yellow, ew_green} = 3'b001;
            S_EW_YELLOW: {ew_red, ew_yellow, ew_green} = 3'b010;
        endcase
    end
endmodule

module tb;

    parameter GREEN_TIME  = 4;
    parameter YELLOW_TIME = 2;

    reg clk;
    reg rst;

    wire ns_red;
    wire ns_yellow;
    wire ns_green;

    wire ew_red;
    wire ew_yellow;
    wire ew_green;

    traffic_controller #(
        .GREEN_TIME(GREEN_TIME),
        .YELLOW_TIME(YELLOW_TIME)
    ) uut (
        .clk(clk),
        .rst(rst),

        .ns_red(ns_red),
        .ns_yellow(ns_yellow),
        .ns_green(ns_green),

        .ew_red(ew_red),
        .ew_yellow(ew_yellow),
        .ew_green(ew_green)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("Traffic_Controller.vcd");
        $dumpvars(0, tb);
    end

    initial begin

        clk = 1'b0;
        rst = 1'b1;

        #12;

        rst = 1'b0;

        #150;

        rst = 1'b1;

        #10;

        rst = 1'b0;

        #80;

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | rst=%b | NS={R:%b Y:%b G:%b} | EW={R:%b Y:%b G:%b}",
            $time,
            rst,
            ns_red,
            ns_yellow,
            ns_green,
            ew_red,
            ew_yellow,
            ew_green
        );
    end

endmodule
