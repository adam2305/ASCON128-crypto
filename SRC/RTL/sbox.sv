/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : sbox.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'sbox'
*
*  input:sbox_i  : vecteur de 5 bits.
*  output:sbox_o : vecteur de 5 bits.
*
*  Le module sbox subsitue un vecteur de 5 bits suivant une 
*  table de valeurs prédefinie.
*/
module sbox(
	input  logic[0:4] sbox_i,

	output logic[0:4] sbox_o );

always @(sbox_i) begin
	case (sbox_i)

		8'h00 : assign sbox_o    = 8'h04;
		8'h01 : assign sbox_o    = 8'h0B;
		8'h02 : assign sbox_o    = 8'h1F;
		8'h03 : assign sbox_o    = 8'h14;
		8'h04 : assign sbox_o    = 8'h1A;
		8'h05 : assign sbox_o    = 8'h15;
		8'h06 : assign sbox_o    = 8'h09;
		8'h07 : assign sbox_o    = 8'h02;
		8'h08 : assign sbox_o    = 8'h1B;
		8'h09 : assign sbox_o    = 8'h05;
		8'h0A : assign sbox_o    = 8'h08;
		8'h0B : assign sbox_o    = 8'h12;
		8'h0C : assign sbox_o    = 8'h1D;
		8'h0D : assign sbox_o    = 8'h03;
		8'h0E : assign sbox_o    = 8'h06;
		8'h0F : assign sbox_o    = 8'h1C;
		8'h10 : assign sbox_o    = 8'h1E;
		8'h11 : assign sbox_o    = 8'h13;
		8'h12 : assign sbox_o    = 8'h07;
		8'h13 : assign sbox_o    = 8'h0E;
		8'h14 : assign sbox_o    = 8'h00;
		8'h15 : assign sbox_o    = 8'h0D;
		8'h16 : assign sbox_o    = 8'h11;
		8'h17 : assign sbox_o    = 8'h18;
		8'h18 : assign sbox_o    = 8'h10;
		8'h19 : assign sbox_o    = 8'h0C;
		8'h1A : assign sbox_o    = 8'h01;
		8'h1B : assign sbox_o    = 8'h19;
		8'h1C : assign sbox_o    = 8'h16;
		8'h1D : assign sbox_o    = 8'h0A;
		8'h1E : assign sbox_o    = 8'h0F;
		8'h1F : assign sbox_o    = 8'h17;
		default : assign sbox_o  = 'x;

	endcase
end 

endmodule : sbox
