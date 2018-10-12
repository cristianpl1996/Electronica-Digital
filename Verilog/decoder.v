`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:32 08/07/2018 
// Design Name: 
// Module Name:    decoder 
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
//////////////////////////////////////////////////////////////////////////////////
module decoder(
    input A,
    input B,
    input E,
    output [0:3] D
    );
	 
wire A_NOT,B_NOT,E_NOT;

not 
	G1(A_NOT,A),
	G2(B_NOT,B),
	G3(E_NOT,E);
	
nand
	G4(D[0],A_NOT,B_NOT,E_NOT),
	G5(D[1],A_NOT,B,E_NOT),
	G6(D[2],A,B_NOT,E_NOT),
	G7(D[3],A,B,E_NOT);
	
endmodule
