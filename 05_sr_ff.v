// Designed by Sanjaykumar R

module sr_ff (
    input  s,
    input  r,
    input  clk,
    output reg q,
    output qbar
);

always @(posedge clk) begin
    case ({s, r})
        2'b00: q <= q;      // No change
        2'b01: q <= 1'b0;   // Reset
        2'b10: q <= 1'b1;   // Set
        2'b11: q <= 1'bx;   // Invalid condition
    endcase
end

assign qbar = ~q;

endmodule

module tb_sr_ff; 
reg s;
reg r;
reg clk;
wire q;
wire qbar; 

// Instantiate the SR Flip-Flop 
sr_ff uut ( .s(s), .r(r), .clk(clk), .q(q), .qbar(qbar) ); // Clock generation 
always #5 clk = ~clk; 

initial begin // Initialize inputs 
clk = 0; s = 0; r = 0; 
$monitor("Time=%0t | CLK=%b | S=%b | R=%b | Q=%b | Qbar=%b", $time, clk, s, r, q, qbar); // 00: No change
  #10; s = 0; r = 0; // 01: Reset 
  #10; s = 0; r = 1; // 10: Set 
  #10; s = 1; r = 0; // 11: Invalid 
  #10; s = 1; r = 1; // Finish simulation 
  #10; 
$finish; 
end 
endmodule
