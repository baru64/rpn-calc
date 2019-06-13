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

endmodule
