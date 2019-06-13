module stack
(
    input   wire            CLK,
    input   wire            RST,
    
    input   wire            PUSH_STB,
    input   wire [7:0]      PUSH_DAT,
    output  reg             PUSH_ACK,
    
    output  reg             POP_STB,
    output  wire [7:0]      POP_DAT,
    input   wire            POP_ACK
);

    reg [3:0]       sp; // stack top pointer
    reg [7:0]       mem [0:15];
    reg [1:0]       stack_state;
    
    always@(posedge CLK or posedge RST)
        if(RST) begin
            PUSH_ACK    <= 1'h0;
            POP_STB     <= 1'h0;
            sp          <= 4'h0;
            stack_state <= 0;
        end
        else casex(stack_state)
//////// empty
        0: begin
//            if (PUSH_STB && POP_ACK) begin
//               PUSH_ACK     <= 1'h1;
//               POP_STB      <= 1'h0;
//               stack_state  <= 1;
//               sp           <= sp ;
//            end
            if(PUSH_STB) begin
                PUSH_ACK    <= 1'h1;
                POP_STB     <= 1'h1;
                stack_state <= 1;
                sp          <= sp + 4'h1;
            end
        end
//////// not empty
        1: begin
            if (PUSH_STB && POP_ACK) begin
               PUSH_ACK     <= 1'h1;
               POP_STB      <= 1'h1;
               stack_state  <= 1;
               sp           <= sp;
            end
            else if (PUSH_STB) begin
               PUSH_ACK     <= 1'h1;
               POP_STB      <= 1'h1;
               stack_state  <= (sp == 4'hF)? 2 : 1;
               //sp           <= (sp == 4'hF)? sp : sp + 4'h1;
               sp           <= sp + 4'h1;
            end
            else if (POP_ACK) begin
               PUSH_ACK     <= 1'h0;
               POP_STB      <= (sp > 4'h1)? 1 : 0;
               stack_state  <= (sp > 4'h1)? 1 : 0; 
               //sp           <= (sp >= 4'h1)? sp - 4'h1 : sp;
               sp           <= sp - 4'h1;
            end
        end
//////// full
        2: begin
            if (PUSH_STB && POP_ACK) begin
               PUSH_ACK     <= 1'h1;
               POP_STB      <= 1'h1;
               stack_state  <= 2;
               sp           <= sp;
            end
            else if (PUSH_STB) begin
               PUSH_ACK     <= 1'h0;
               POP_STB      <= 1'h1;
               stack_state  <= 2;
               sp           <= sp;
            end
            else if (POP_ACK) begin
               POP_STB      <= 1'h1;
               stack_state  <= 1;
               sp           <= sp - 4'h1;
            end
        end
    endcase
/////////////
    
    always@(negedge CLK) $display("mem[%d]=%d", sp, mem[sp]);

    always@(posedge CLK) begin 
        if (PUSH_STB && POP_ACK && stack_state != 0) mem[sp - 1] <= PUSH_DAT;
        else if (PUSH_STB && stack_state != 2) mem[sp] <= PUSH_DAT;
    end

    assign      POP_DAT = mem [(sp)? sp - 4'h1 : 4'hF];
    //assign      POP_DAT = mem [sp];

endmodule
