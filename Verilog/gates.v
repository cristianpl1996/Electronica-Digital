`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:35:58 08/07/2018 
// Design Name: 
// Module Name:    gates 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////^~
module gates(
    input A,
    input B,
    input C,
    output F
    );

assign F = (A&B)^((~B)|C);
endmodule
