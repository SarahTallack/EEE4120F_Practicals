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
    input [12:0] shift,
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
        i = shift - 1;
        j = (shift+256)%1024;
    end
    
    assign sine_shifted = out;
    
    always @(posedge clk)begin
        if (sine>=16'h8000) begin
            cos_in = 16'h7fff**2'd2 - ((sine-16'h8000)**2'd2);
        end else begin
            cos_in = 16'h7fff**2'd2 - ((16'hffff-sine-16'h8000)**2'd2);
        end
        
        cos_in = $sqrt(cos_in);
        
        
        if (k == 0) begin
            k = (cos_in == 1'b0) ? 1'b1 : 1'b0;
            cos_in = cos_in + 16'h7fff;
        end else begin
            k = (cos_in == 1'b0) ? 1'b0 : 1'b1;
            cos_in = 16'h7fff - cos_in;
        end
        
        sine_s = rom_memory[i]; //sine of the shifted value
        cos_s = rom_memory[j]; //cos of the shifted value        
        
        term1 = sine*cos_s/16'hFFFF;
        term2 = cos_in*sine_s/16'hFFFF;
        out = 2'd2*((term1 + term2));
        
    end
endmodule
