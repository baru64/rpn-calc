// ascii codes definition
`define BRACKET_OPEN 8'h28
`define BRACKET_CLOSE 8'h29
`define NUM_0 8'h30
`define MINUS_SGN 8'h2d
`define PLUS_SGN 8'h2b
`define MUL_SGN 8'h2a
`define DIV_SGN 8'h2f
`define EQU_SGN 8'h3d

module alu
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

reg [2:0] operation; // 0 - noop, 1 -, 2 +, 3 *, 4 /
reg [7:0] last_num;

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

always@(posedge CLK or posedge RST) begin
    if (RST) begin
        IN_ACK <= 0;
        OUT_STB <= 0;
        s_push_stb <= 0;
        s_pop_ack <= 0;
    end
    else if (operation) begin
        IN_ACK <= 0;
        OUT_STB <= 0;
        casex(operation)
            1: begin // add
                 s_push_stb <= 1;
                 s_pop_ack <= 1;
                 s_push_dat <= 
                 8'h30 + ((last_num - 8'h30) + (s_pop_dat - 8'h30));
                 operation <= 0;
            end
            2: begin // sub
                 s_push_stb <= 1;
                 s_pop_ack <= 1;
                 s_push_dat <=
                 8'h30 + ((last_num - 8'h30) - (s_pop_dat - 8'h30));
                 operation <= 0;
            end
            3: begin // mul
                 s_push_stb <= 1;
                 s_pop_ack <= 1;
                 s_push_dat <=
                 8'h30 + ((last_num - 8'h30) * (s_pop_dat - 8'h30));
                 operation <= 0;
            end
            4: begin // div
                 s_push_stb <= 1;
                 s_pop_ack <= 1;
                 s_push_dat <= 
                 8'h30 + ((last_num - 8'h30) / (s_pop_dat - 8'h30));
                 operation <= 0;
            end
        endcase
    end
    // brackets
    else if (IN_STB) begin
        // numbers
        if (IN_CHAR >= `NUM_0 && IN_CHAR <= (`NUM_0 + 10)) begin
            s_push_stb <= 1;
            s_pop_ack <= 0;
            s_push_dat <= IN_CHAR;
            operation <= 0;
            IN_ACK <= 1;
            OUT_STB <= 0;
        end
        // + sign
        else if (IN_CHAR == `PLUS_SGN) begin
            s_push_stb <= 0;
            s_pop_ack <= 1;
            last_num <= s_pop_dat;
            operation <= 1;
            IN_ACK <= 1;
            OUT_STB <= 0;
        end
        // - sign
        else if (IN_CHAR == `MINUS_SGN) begin
            s_push_stb <= 0;
            s_pop_ack <= 1;
            last_num <= s_pop_dat;
            operation <= 2;
            IN_ACK <= 1;
            OUT_STB <= 0;
        end
        // * sign
        else if (IN_CHAR == `MUL_SGN) begin
            s_push_stb <= 0;
            s_pop_ack <= 1;
            last_num <= s_pop_dat;
            operation <= 3;
            IN_ACK <= 1;
            OUT_STB <= 0;
        end 
        // / sign
        else if (IN_CHAR == `DIV_SGN) begin
            s_push_stb <= 0;
            s_pop_ack <= 1;
            last_num <= s_pop_dat;
            operation <= 4;
            IN_ACK <= 1;
            OUT_STB <= 0;
        end
        // = sign
        else if (IN_CHAR == `EQU_SGN) begin
            s_push_stb <= 0;
            s_pop_ack <= 1;
            OUT_CHAR <= s_pop_dat;
            IN_ACK <= 1;
            OUT_STB <= 0;
        end
    end
end

endmodule
