// Designed by Sanjaykumar R

module piso_shift_reg (
    input  wire clk,
    input  wire rst,
    input  wire load,
    input  wire [7:0] parallel_in,
    output wire serial_out
);

    reg [7:0] shreg;

    always @(posedge clk) begin
        if (rst)
            shreg <= 8'b0;
        else if (load)
            shreg <= parallel_in;
        else
            shreg <= {shreg[6:0], 1'b0};
    end

    assign serial_out = shreg[7];

endmodule

module tb;

    reg clk;
    reg rst;
    reg load;
    reg [7:0] parallel_in;
    wire serial_out;

    piso_shift_reg uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .parallel_in(parallel_in),
        .serial_out(serial_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("PISO_Shift_Register.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        clk = 0;
        rst = 1;
        load = 0;
        parallel_in = 8'b0;

        #12;
        rst = 0;

        parallel_in = 8'b10110011;
        load = 1;

        #10;

        load = 0;

        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;
        #10;

        rst = 1;
        #10;

        rst = 0;
        #20;

        $finish;
    end

    initial begin
        $monitor(
            "Time=%0t | rst=%b | load=%b | parallel_in=%b | serial_out=%b",
            $time, rst, load, parallel_in, serial_out
        );
    end

endmodule
