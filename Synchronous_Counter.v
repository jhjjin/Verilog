`timescale 1ns / 1ps
module topCounter (reset,clk, Q);
    input reset, clk;
    output [2:0] Q;
    Synch_counter counter(reset,1'b1, clk, Q[0]&Q[2], 3'b000, Q);
    
endmodule
 
module Synch_counter(
    input reset,E, 
    input clk, 
    input L, 
     input [2:0]D, 
    output reg [2:0]Q
 );
    always@(posedge clk)
    begin
         if(L||reset)
             Q <= D;
         else
            if(E)
            begin
            Q<=Q+1;
            end
    end
    
endmodule
