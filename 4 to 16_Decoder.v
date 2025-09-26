`timescale 1ns / 1ps

module connect(
    input  [3:0] data,    // 4-bit input
    output [6:0] C,       // 7 segment outputs
    output [7:0] AN       // Anode for 7 segment
);
    // Internal wires
    wire [15:0] w;        
    wire [6:0]  c_wire;   
    wire [7:0]  an_wire;  

    // Decode 4-bit data into 16 bit output
    decoder dec(
        .data(data),
        .y(w)
    );

    // Convert 16 bit to the 7 segment and 
    controller ctrl(
        .x(w),
        .C(c_wire),
        .AN(an_wire)
    );

    // Drive the outputs from the wires
    assign C  = c_wire;
    assign AN = an_wire;
endmodule

module decoder(
    input  [3:0] data,
    output reg [15:0] y
);
    always @(*) begin
        y = 16'b0; // Start with all zeros
        y[data] = 1'b1; 
    end
endmodule

module controller(
    input  [15:0] x,
    output reg [6:0] C,     // 7 segments
    output reg [7:0] AN     // Anodes 
);
    always @(*) begin
        AN = 8'b11111110; // AN[0]
        C  = 7'b1111111;  // All segment off 

        case(x)
            16'b0000000000000001: C = 7'b1000000; // 0
            16'b0000000000000010: C = 7'b1111001; // 1
            16'b0000000000000100: C = 7'b0100100; // 2
            16'b0000000000001000: C = 7'b0110000; // 3
            16'b0000000000010000: C = 7'b0011001; // 4
            16'b0000000000100000: C = 7'b0010010; // 5
            16'b0000000001000000: C = 7'b0000010; // 6
            16'b0000000010000000: C = 7'b1111000; // 7
            16'b0000000100000000: C = 7'b0000000; // 8
            16'b0000001000000000: C = 7'b0010000; // 9
            16'b0000010000000000: C = 7'b0001000; // A (10)
            16'b0000100000000000: C = 7'b0000011; // b (11)
            16'b0001000000000000: C = 7'b1000110; // C (12)
            16'b0010000000000000: C = 7'b0100001; // d (13)
            16'b0100000000000000: C = 7'b0000110; // E (14)
            16'b1000000000000000: C = 7'b0001110; // F (15)
            default: begin
                
                C  = 7'b1111111;  
                AN = 8'b11111111;
            end
        endcase
    end
endmodule

