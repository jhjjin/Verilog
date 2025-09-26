`timescale 1ns / 1ps

module Reduction(A,Y5,Y6);

    input [7:0] A;
    output reg Y5,Y6;

    always@(A)
    begin
    Y5=^A; // Reduction XOR
    Y6 = ~^A; // Reduiction XNOR
    end
endmodule



//Simulation
`timescale 1ns / 1ps

module sim_Reduction;
    reg [7:0] A;
    wire Y5,Y6;
    Reduction uut(A,Y5,Y6);
    
    initial 
    begin
     A=0;
     #1 A=01001000;
     #1 A= 01101001;
     #1 A = 00110001;
    end
endmodule
