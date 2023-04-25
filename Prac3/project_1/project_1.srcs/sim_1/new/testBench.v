`timescale 1ns / 1ps

module testBench;
    reg clk;
    wire [15:0] sine;
    wire [19:0] shifted;
    wire [12:0] shift = 12'd1024;
    
    //initates and connects the sine generator to the testBench
    sine_gen baseSineGen(
        .clk (clk),
        .sineOutput (sine)
    );
    
    shifter shiftSineGen(
        .clk (clk),
        .sine(sine),
        .shift(shift),
        .sine_shifted(shifted)
    );
    
    
    //frequency control
    parameter freq = 100000000; //100 MHz //(1/1MHz)/1024/1000ps
    parameter SIZE = 1024; 
    parameter clockRate = 0.005; //clock time (make this an output from the sine modules)
    
    //Generate a clock with the above frequency control
    initial
    begin 
    clk = 1'b0;
    end
    always #clockRate clk = ~clk; //#1 is one nano second delay (#x controlls the speed)
    
endmodule
