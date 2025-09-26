`timescale 1ns / 1ps
module shift4 (R, L, w, Clock, Q);
  input [3:0] R;
  input L, w, Clock;// w is the serial input, L is the control to load the data
  output [3:0] Q;
  wire [3:0] Q;

  muxdff Stage3 (w, R[3], L, Clock, Q[3]);
  muxdff Stage2 (Q[3], R[2], L, Clock, Q[2]);
  muxdff Stage1 (Q[2], R[1], L, Clock, Q[1]);
  muxdff Stage0 (Q[1], R[0], L, Clock, Q[0]);
endmodule


module muxdff (D0, D1, Sel, Clock, Q);
  input D0, D1, Sel, Clock;
  output reg Q;
  wire D;
  assign D = Sel ? D1 : D0;
  always @(posedge Clock)
        Q = D;
endmodule
