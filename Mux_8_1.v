`timescale 1ns / 1ps

module mux8to1(W,S,f);
input [7:0] W;
input [2:0] S;
output reg f;
always @(W,S)
    case(S)
        0: f=W[0];
        1: f=W[1];
        2: f=W[2];
        3: f=W[3];
        4: f=W[4];
        5: f=W[5];
        6: f=W[6];
        7: f=W[7];
       endcase 
endmodule


//Simulation 
`timescale 1ns / 1ps

module Sim_8To1Mux;
reg [7:0] W;
reg [2:0] S;
wire f;

integer s;
integer k;
mux8to1 uut(W,S,f);

initial 
begin
W= 8'b0;S=3'b0;
    for (integer s = 0; s < 256; s = s + 1) 
    begin  
    #1 W = s;
      for (integer k = 0; k < 8; k= k + 1) 
      begin 
     #1 S = k;
      end
end
end

endmodule
