`timescale 1ns / 1ps
module topCounter (reset,clk,clear, load, Q);
    input reset, clk, clear, load;
    output [3:0] Q;
    bcd_counter0(reset,1'b1, clear, clk, Q[0]&Q[3], 4'b0000, Q);
    bcd_counter1(reset,Q[0]&Q[3], clear, clk, Q[0]&Q[3], 4'b0000, Q);
    
endmodule
 
module bcd_counter0(
    input reset,E, clear,
    input clk, 
    input L, 
     input [3:0]D, 
    output reg [3:0]Q
 );
    always@(posedge clk)
    begin
         if(L |reset)
             Q <= D;
         else
            if(E)
            begin
            Q<=Q+1;
            end
    end
    
endmodule

module bcd_counter1(
    input reset,E, clear,
    input clk, 
    input L, 
     input [3:0]D, 
    output reg [3:0]Q
 );
    always@(posedge clk)
    begin
         if(L |reset)
             Q <= D;
         else
            if(E)
            begin
            Q<=Q+1;
            end
    end
    
endmodule
