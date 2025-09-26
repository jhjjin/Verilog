`timescale 1ns / 1ps

module overflow (carryin, X, Y, S, carryout, overflow);
  parameter n = 8;  
  input carryin;
  input [n-1:0] X, Y;
  output reg [n-1:0] S;
  output reg carryout, overflow;

  always @(X, Y, carryin)

  begin

  S = X + Y + carryin;

  carryout = (X[n-1] & Y[n-1]) | (X[n-1] & ~S[n-1]) | (Y[n-1] & ~S[n-1]);

  overflow = (X[n-1] & Y[n-1] & ~S[n-1]) | (~X[n-1] & ~Y[n-1] & S[n-1]);

  end

  endmodule


//Simulation
`timescale 1ns / 1ps
module sim_overflow;

  parameter n = 8;  
  reg carryin;
  reg [n-1:0] X, Y;
  wire [n-1:0] S;
  wire carryout, overflow;
 overflow uut(carryin, X, Y, S, carryout, overflow);
 
 initial 
 begin
 carryin =0;
  X =0;
  Y = 0;
  #1 X = 64; Y = 64;
  #1 X= 127; Y = -1;
  #1 X = -128; Y = 2;
  #1 X= -63; Y = -65;
 end 
endmodule
