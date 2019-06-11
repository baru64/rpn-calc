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


endmodule
