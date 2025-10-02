`timescale 1ns / 1ps


module SongPlayer( input clock, input reset, input playSound, output reg
audioOut, output wire aud_sd);
reg [19:0] counter;
reg [31:0] time1, noteTime;
reg [9:0] msec, number; //millisecond counter, and sequence number of musical

    wire [4:0] note, duration;
    wire [19:0] notePeriod;
    parameter clockFrequency = 100_000_000;
    assign aud_sd = 1'b1;
    MusicSheet mysong(number, notePeriod, duration );
    always @ (posedge clock)
    begin
    if(reset | ~playSound)
    begin
    counter <=0;
    time1<=0;
    number <=0;
    audioOut <=1;
    end
    else
    begin
    counter <= counter + 1;
    time1<= time1+1;
    if( counter >= notePeriod)
    begin
    counter <=0;
    audioOut <= ~audioOut ;
    end //toggle audio output
    if( time1 >= noteTime)
    begin
    time1 <=0;
    number <= number + 1;
    end //play next note
    if(number == 48) number <=0; // Make the number reset at the end of the song
        end
    end
always @(duration) noteTime = duration * (clockFrequency/8);
//number of FPGA clock periods in one note.
endmodule
    

module MusicSheet( input [9:0] number,
    output reg [19:0] note,//what is the max frequency
    output reg [4:0] duration);
    parameter QUARTER = 5'b00010;
    parameter HALF = 5'b00100;
    parameter ONE = 2* HALF;
    parameter TWO = 2* ONE;
    parameter FOUR = 2* TWO;
    parameter C4=95556.62, D4=85131.02, E4 = 75843.76, F4=7159.775, G4 = 63776.32,C5 = 19113.2, SP = 1;
    always @ (number) begin
    case(number) //Row Row Row your boat
    0: begin note = C4; duration = HALF; end //row
    1: begin note = SP; duration = HALF; end //
    2: begin note = C4; duration = HALF; end //row
    3: begin note = SP; duration = HALF; end //
    4: begin note = C4; duration = HALF; end //row
    5: begin note = SP; duration = HALF; end //
    6: begin note = D4; duration = HALF; end //your
    7: begin note = E4; duration = HALF; end //boat
    8: begin note = SP; duration = HALF; end //
    9: begin note = E4; duration = HALF; end //gently
    10: begin note = SP; duration = HALF; end //
    11: begin note = D4; duration = HALF; end //down
    12: begin note = E4; duration = HALF; end //
    13: begin note = SP; duration = HALF; end //
    14: begin note = F4; duration = HALF; end //the
    15: begin note = G4; duration = HALF; end //stream
    16: begin note = SP; duration = HALF; end //
    17: begin note = C5; duration = HALF; end //merrily
    18: begin note = SP; duration = QUARTER; end //
    19: begin note = C5; duration = HALF; end //
    20: begin note = SP; duration = QUARTER; end //
    21: begin note = C5; duration = HALF; end //
    22: begin note = SP; duration = QUARTER; end //
    23: begin note = G4; duration = HALF; end //
    24: begin note = SP; duration = QUARTER; end //
    25: begin note = G4; duration = HALF; end //
    26: begin note = SP; duration = QUARTER; end //
    27: begin note = G4; duration = HALF; end //
    28: begin note = SP; duration = QUARTER; end //
    29: begin note = E4; duration = HALF; end //
    30: begin note = SP; duration = QUARTER; end //
    31: begin note = E4; duration = HALF; end //
    32: begin note = SP; duration = QUARTER; end //
    33: begin note = E4; duration = HALF; end //
    34: begin note = SP; duration = QUARTER; end //
    35: begin note = C4; duration = HALF; end //
    36: begin note = SP; duration = QUARTER; end //
    37: begin note = C4; duration = HALF; end //
    38: begin note = SP; duration = QUARTER; end //
    39: begin note = C4; duration = HALF; end //
    40: begin note = SP; duration = QUARTER; end //
    41: begin note = G4; duration = ONE; end //Life
    42: begin note = SP; duration = HALF; end //
    43: begin note = F4; duration = HALF; end //is
    44: begin note = E4; duration = HALF; end //but
    45: begin note = SP; duration = HALF; end //
    46: begin note = D4; duration = HALF; end //a
    47: begin note = C4; duration = HALF; end //dream
    default: begin note = C4; duration = FOUR; end
    endcase
end
endmodule


