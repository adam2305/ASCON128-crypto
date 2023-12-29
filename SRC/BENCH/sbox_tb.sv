/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : sbox_tb.sv
*  Description : Testbench
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
* 
* Module 'sbox_tb'
*
* Testbech du composant sbox 
*
*/
module sbox_tb();

	logic[0:4] sbox_i_s;
	logic[0:4] sbox_o_s;

	sbox sbox_DUT(
		.sbox_i(sbox_i_s),
		.sbox_o(sbox_o_s) );

initial
begin
	sbox_i_s = 8'h1F;
	#10;
end 

endmodule : sbox_tb
