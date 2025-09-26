`timescale 1ns / 1ps

module DLatch(D, En, Q);
    input D;
    input En;
    output Q;
    reg Q;
    always @(D or En)
        if (En)
        begin
        Q = D;
        end
endmodule

//Simulation

`timescale 1ns / 1ps


module sim_dlatch;

    reg D;
    reg En;
    wire Q;
    DLatch uut(D, En, Q);
    
    initial 
    begin
    #1 D = 1;En = 1; 
    #1 D = 0;En = 1; 
    #1 D = 1;En = 0; 
    #1 D = 1;En = 1; 
    #1 D = 0;En = 1; 
    
    
    end

endmodule
