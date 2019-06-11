module testbench;

reg clk = 1;
reg reset = 0;

reg push = 0;
reg [0:7] push_dat = 0;
wire push_ack;

wire pop;
wire [0:7] pop_dat;
reg pop_ack = 0;

always #5 clk = !clk;

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,testbench);
    
    # 10    reset = 1;
    # 10    reset = 0;
    # 10    push = 1; push_dat = 8'h0; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h1; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h2; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h3; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h4; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h5; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h6; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h7; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h8; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h9; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hA; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hB; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hC; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hD; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hE; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hF; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hB; pop_ack = 0;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 1; push_dat = 8'h0; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h1; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h2; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h3; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h4; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h5; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h6; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h7; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h8; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h9; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hA; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hB; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hC; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hD; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hF; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hA; pop_ack = 0;
    # 10    push = 1; push_dat = 8'hB; pop_ack = 0;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h0; pop_ack = 1;
    # 10    push = 1; push_dat = 8'h8; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h9; pop_ack = 0;
    # 10    push = 1; push_dat = 8'h1; pop_ack = 1;
    # 10    push = 1; push_dat = 8'h2; pop_ack = 1;
    # 10    push = 1; push_dat = 8'h3; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h4; pop_ack = 1;
    # 10    push = 0; push_dat = 8'h5; pop_ack = 1;
    # 10    $stop;
end

reg [7:0] test;

always@(posedge clk)
    if (pop) test <= pop_dat;

stack stk1
(
clk,
reset,
push,
push_dat,
push_ack,
pop,
pop_dat,
pop_ack
);

initial
    $monitor("At time %t, clk=%d | rst=%d | push=%d | push_dat=%d | push_ack=%d | pop=%d | pop_dat=%d | pop_ack=%d",
             $time, clk, reset, push, push_dat, push_ack, pop, pop_dat, pop_ack);

endmodule
