`timescale 1ns / 1ps
module tff (T, Clock, Resetn, Q);
input T, Clock, Resetn;
output reg [2:0]Q;
always @(negedge Resetn, posedge Clock)
    if (!Resetn)
        Q = 0;
    else
        begin
            if (T)
                Q <= Q + 1;
            else
                Q <= Q - 1;
        end
endmodule


//Simulation Code
`timescale 1ns / 1ps
module sim_tff;
    reg T, Clock, Resetn;
    wire [2:0] Q;
    tff uut(T, Clock, Resetn, Q);
    initial 
    begin
    T = 0; Clock = 0; Resetn = 0;
    #10 Resetn = 1;
    #10;
    T = 1;
    #100
    #10 Resetn = 0;
    #10;
    #10 Resetn = 1;
    #10;
    T = 0;
    #100
    $finish;
    end
    always begin
        #5 Clock = ~Clock;
    end
endmodule
