// ascii codes definition
`define BRACKET_OPEN
`define BRACKET_CLOSE
`define NUM_0
`define MINUS_SGN
`define PLUS_SGN
`define MUL_SGN
`define DIV_SGN

module onp
(
    input   wire        CLK,
    input   wire        RST,

    input   wire        IN_STB,
    input   wire [7:0]  IN_CHAR,
    output  reg         IN_ACK,

    output  reg         OUT_STB,
    output  reg [7:0]   OUT_CHAR,
    input   wire        OUT_ACK
);

reg [3:0] nest_lvl; // bracket counter
reg [3:0] on_stack; // stack size

reg s_push_stb;
reg s_push_dat;
wire s_push_ack;

wire s_pop_stb;
reg s_pop_dat;
reg s_pop_ack;

stack stk
(
CLK,
RST,

s_push_stb,
s_push_dat,
s_push_ack,

s_pop_stb,
s_pop_dat,
s_pop_ack
);


always@(CLK or RST) begin
    if (RST) begin
        IN_ACK <= 0;
        OUT_STB <= 0;
        nest_lvl <= 4'h0;
        on_stack <= 4'h0;
    end
    // if something on stack to pop
    else if (on_stack > nest_lvl) begin
    end
    // brackets
    else if (IN_CHAR == `BRACKET_OPEN) begin
    end
    else if (IN_CHAR == `BRACKET_CLOSE) begin
    end
    // numbers
    else if () begin
    end
    // +- signs
    else if () begin
    end
    // */ signs
    else if () begin
    end
end

endmodule
