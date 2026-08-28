// Designed by Sanjaykumar R

module siso_shift_reg (
    input  wire clk,
    input  wire rst,
    input  wire serial_in,
    output wire serial_out
);

    reg [7:0] shreg;

    always @(posedge clk) begin
        if (rst)
            shreg <= 8'b0;
        else
            shreg <= {shreg[6:0], serial_in};
    end

    assign serial_out = shreg[7];

endmodule

module tb;

    reg clk;
    reg rst;
    reg serial_in;
    wire serial_out;

    siso_shift_reg uut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .serial_out(serial_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("SISO_Shift_Register.vcd");
        $dumpvars(0, tb);
    end

    initial begin

        clk = 1'b0;
        rst = 1'b1;
        serial_in = 1'b0;

        #12;

        rst = 1'b0;

        #3  serial_in = 1'b1;
        #10 serial_in = 1'b0;
        #10 serial_in = 1'b1;
        #10 serial_in = 1'b1;
        #10 serial_in = 1'b0;
        #10 serial_in = 1'b0;
        #10 serial_in = 1'b1;
        #10 serial_in = 1'b1;

        #80;

        rst = 1'b1;
        #10;

        rst = 1'b0;
        serial_in = 1'b0;

        #30;

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | clk=%b | rst=%b | serial_in=%b | serial_out=%b | shreg=%b",
            $time,
            clk,
            rst,
            serial_in,
            serial_out,
            uut.shreg
        );
    end

endmodule
