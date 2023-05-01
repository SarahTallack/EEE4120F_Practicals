`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2023 15:07:21
// Design Name: 
// Module Name: shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shifter(
    input clk,
    input [15:0] sine,
    input [12:0] shift, //in degrees
    output [19:0] sine_shifted
    );
    
    parameter SIZE = 1024;    
    reg [15:0] rom_memory [SIZE-1:0];
    reg [32:0] cos_in, term1, term2;
    reg [16:0] sine_s;
    reg [32:0] cos_s;
    reg [50:0] out = 0;
    reg [31:0] test;
    integer i;
    integer j;
    reg k = 1'b1;
    reg p = 1'b0;
    
    initial begin
        $readmemh("sine_LUT_values.mem", rom_memory); //Use IP of BRAM instead of this command
        i = shift*1024/360;
    end
    
    assign sine_shifted = out;
    
    always @(posedge clk)begin
    
        out = 2'd2*rom_memory[i];
        i = i+ 1;
        if(i == SIZE)
            i = 0;
    
    end
endmodule
