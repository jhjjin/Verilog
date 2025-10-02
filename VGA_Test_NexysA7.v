`timescale 1ns / 1ps

module vga_test
   (
    input wire clk, reset,
    input wire [11:0] sw,
    output wire hsync, vsync,
    output wire [11:0] rgb
   );

   //signal declaration
   reg [11:0] rgb_reg;
   wire video_on;

   // instantiate vga sync circuit
   vga_sync vsync_unit
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(), .pixel_x(), .pixel_y());
   // rgb buffer
   always @(posedge clk, posedge reset)
      if (reset)
         rgb_reg <= 0;
      else
         rgb_reg <= sw;
   // output
   assign rgb = (video_on) ? rgb_reg : 11'b0;

endmodule

