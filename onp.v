// ascii codes definition
`define BRACKET_OPEN 8'h28
`define BRACKET_CLOSE 8'h29
`define NUM_0 8'h30
`define MINUS_SGN 8'h2d
`define PLUS_SGN 8'h2b
`define MUL_SGN 8'h2a
`define DIV_SGN 8'h2f
`define EQU_SGN 8'h3d

module onp
(
    input   wire        CLK,
    input   wire        RST,

    input   wire        IN_STB, // input ready
    input   wire [7:0]  IN_CHAR,
    output  reg         IN_ACK, // idle

    output  reg         OUT_STB, // output ready
    output  reg [7:0]   OUT_CHAR,
    input   wire        OUT_ACK  // output taken
);

//reg [3:0] nest_lvl; // bracket counter
reg bracket_block;
reg [3:0] on_stack; // stack size
reg first_char;
reg take_more;

reg s_push_stb;
reg [7:0] s_push_dat;
wire s_push_ack;

wire s_pop_stb;
wire [7:0] s_pop_dat;
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

// oddzielić datapath(in_char, out_char) od control(stb,ack)?
always@(posedge CLK or posedge RST) begin
    if (RST) begin
        IN_ACK <= 0;
        OUT_STB <= 0;
        bracket_block <= 0;
        on_stack <= 4'h0;
        first_char <= 1;
        take_more <= 0;
        s_pop_ack <= 0;
        s_push_stb <= 0;
        s_push_dat <= 0;
    end
    // if something on stack to pop
    else if (take_more) begin
        if (IN_ACK) IN_ACK <= 0;
        s_pop_ack <= 1;
        s_push_stb <= 0;
        OUT_CHAR <= s_pop_dat;
        OUT_STB <= 1;
        IN_ACK <= 0;
        take_more <= 0;
    end
    // brackets
    else if ((OUT_ACK || first_char) && IN_STB) begin // if last char has been read and input ready
        if (IN_ACK) IN_ACK <= 0;
        if (first_char) first_char <= 0;
        if (IN_CHAR == `BRACKET_OPEN) begin
            s_pop_ack <= 0;
            s_push_stb <= 0;
            bracket_block <= 1;
            OUT_STB <= 0;
            IN_ACK <= 1;
        end
        else if (IN_CHAR == `BRACKET_CLOSE) begin
            s_pop_ack <= 1;
            s_push_stb <= 0;
            OUT_CHAR <= s_pop_dat;
            OUT_STB <= 1;
            IN_ACK <= 1;
        end
        // numbers
        else if (IN_CHAR >= `NUM_0 && IN_CHAR <= (`NUM_0 + 10)) begin
            s_pop_ack <= 0;
            s_push_stb <= 0;
            OUT_CHAR <= IN_CHAR;
            OUT_STB <= 1;
            IN_ACK <= 1;
        end
        // +- signs
        else if (IN_CHAR == `MINUS_SGN || IN_CHAR == `PLUS_SGN) begin
            s_push_stb <= 1;
            s_push_dat <= IN_CHAR;
            IN_ACK <= 1;
            if (s_pop_stb && !bracket_block) begin
                s_pop_ack <= 1;
                OUT_CHAR <= s_pop_dat;
                OUT_STB <= 1;
                bracket_block <= 0;
            end else begin
                s_pop_ack <= 0;
                OUT_STB <= 0;
            end
        end
        // */ signs
        else if (IN_CHAR == `MUL_SGN || IN_CHAR == `DIV_SGN) begin
            s_push_stb <= 1;
            s_pop_ack <= 0;
            s_push_dat <= IN_CHAR;
            take_more <= 1;
            IN_ACK <= 1;
            OUT_STB <= 0;
        end 
        else if (IN_CHAR == `EQU_SGN) begin
            s_pop_ack <= 1;
            OUT_CHAR <= s_pop_dat;
            OUT_STB <= 1;
            IN_ACK <= 1;
            s_push_stb <= 1;
            s_push_dat <= IN_CHAR;
            take_more <= 1;
            first_char <= 1;
        end
    end else if (IN_ACK) IN_ACK <= 0;
end

endmodule
