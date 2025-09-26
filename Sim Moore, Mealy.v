`timescale 1ns / 1ps

module sim_topModule;
    reg clk, reset, level;
    wire tick_moore, tick_mealy;
    topModule uut(clk, reset, level,tick_moore, tick_mealy);
    
    always begin
    #5 clk =~clk;
    
    end 
    
    initial begin
    clk=0; reset=0; level =0;

    #5 reset =1;
    #5 reset = 0; 
  
 
   
    
   
    #10 level = 0;
    #10 level = 1;
     #5 reset =1;
    #5 reset = 0; 
    #10 level = 0;
    #10 level = 1;
   
    #10 level = 0;
    #10 level = 1;
    #10 level = 0;
    #10 level = 1;
    #10 level = 0;
    
    #5 reset =1;
    #5 reset = 0; 
    #10 level = 1;
    #10 level = 0;
    #10 level = 1;
    #10 level = 0;
    #10 level = 1;
    #10 level = 0;
    #10 level = 1;
    
 
  
 end
endmodule
