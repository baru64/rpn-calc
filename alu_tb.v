`define BRACKET_OPEN 8'h28
`define BRACKET_CLOSE 8'h29
`define NUM_0 8'h30
`define MINUS_SGN 8'h2d
`define PLUS_SGN 8'h2b
`define MUL_SGN 8'h2a
`define DIV_SGN 8'h2f
`define EQU_SGN 8'h3d

module testbench;

reg clk = 1;
reg reset = 0;

reg in_stb = 0;
reg [0:7] in_char = 0;
wire in_ack;

wire out_stb;
wire [0:7] out_char;
reg out_ack = 0;

always #5 clk = !clk;

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,testbench);
    
    # 10    reset = 1;
    # 10    reset = 0;
    # 10    in_stb <= 1; in_char <= 8'h32;
    # 10    in_stb <= 0; in_char <= 8'h32;
    # 10 if (in_ack) in_stb <= 1; in_char <= 8'h31;
    # 10    in_stb <= 0;
    # 10 if (in_ack) in_stb <= 1; in_char <= `PLUS_SGN;
    # 10    in_stb <= 0;
    # 10    in_stb <= 1; in_char <= `EQU_SGN;
    # 10    in_stb <= 1;
    # 10    in_stb <= 1;
    # 10    in_stb <= 0;
    # 30    $stop;
end

reg [7:0] test;

always@(posedge clk)
    if (out_stb) test <= out_char;

alu alu1
(
clk,
reset,
in_stb,
in_char,
in_ack,
out_stb,
out_char,
out_ack
);

initial
    $monitor("At time %t, clk=%d | rst=%d | in_stb=%d | in_char=%d | in_ack=%d | out_stb=%d | out_char=%d | out_ack=%d",
             $time, clk, reset, in_stb, in_char, in_ack, out_stb, out_char, out_ack);

endmodule
