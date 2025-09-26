`timescale 1ns / 1ps

module topModule(
            input clk, reset, level, 
            output wire tick_moore, tick_mealy);

edge_detect_moore moore(
        .clk(clk),
        .reset(reset),
        .level(level),
        .tick(tick_moore)
);
edge_detect_mealy mealy(
        .clk(clk),
        .reset(reset),
        .level(level),
        .tick(tick_mealy)
);    

endmodule 
        
module edge_detect_moore (input wire clk, reset, level, output reg tick);
    localparam [1:0] zero=2'b00, edg=2'b01, one=2'b10;
    reg [1:0] state_reg, state_next;
    always @(posedge clk, posedge reset)
    if (reset)
    state_reg<=zero;
    else
    state_reg<=state_next;
    always@*
    begin
    state_next=state_reg;
    tick=1'b0; //default output
    case (state_reg)
    
    zero:
    begin
    tick=1'b0;
    if (level)
    state_next=edg;
    end
    
    edg:
    begin
    tick=1'b1;
    if (level)
    state_next=one;
    else
    state_next=zero;
    end
    
    one:
    if (~level)
    state_next=zero;
    default: state_next=zero;
    endcase
end
endmodule

module edge_detect_mealy (input wire clk, reset, level,output reg tick);
        localparam zero=1'b0, one=1'b1;
        reg state_reg, state_next;
        
        always @(posedge clk, posedge reset)
        if (reset)
        state_reg<=zero;
        else
       
        state_reg<=state_next;
        always@*
        begin
        state_next=state_reg;
        tick=1'b0;
       
        case (state_reg)
        zero:
        if (level)
        begin
        tick=1'b1; //this change is immediate
        state_next=one;
        end
        
        one:
        if (~level)
        state_next=zero;
        default:
        state_next=zero;
        endcase
end
endmodule



// Simulation
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
