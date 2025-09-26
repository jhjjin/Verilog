`timescale 1ns / 1ps
module shift4 (R, L, w, Clock, Q);

  input [3:0] R;
  input L, w, Clock;
  output reg [3:0] Q;

  always @(posedge Clock)
     if (L)
         Q <= R;
    else
         begin
            Q[0] <= Q[1]; //non-blocking statements, will be introduced next
            Q[1] <= Q[2];
            Q[2] <= Q[3];
            Q[3] <= w;
        end
endmodule 



//Simulation
`timescale 1ns / 1ps


module sim_shift;

  reg [3:0] R;
  reg L, w, Clock;
  wire [3:0] Q;
  shift4 uut(R, L, w, Clock, Q);
  
  initial
  begin
  #1 R=0; L=1; w=1;Clock =0;
  end

endmodule

