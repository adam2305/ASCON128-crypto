/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : pc_tb.sv
*  Description : testbench
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
* Module 'pc_tb.sv'
*
* Testbench du composant pc.
*
*/
module pc_tb();

	type_state state_i_s;
	logic[3:0] round_i_s;
	type_state state_o_s;

	pc PC_DUT(
    	.state_i(state_i_s),
    	.round_i(round_i_s),
    	.state_o(state_o_s) );

//Etat courant en entrée
initial begin
	state_i_s[0] = 64'h80400c0600000000;
	state_i_s[1] = 64'h0001020304050607;
	state_i_s[2] = 64'h08090a0b0c0d0e0f;
	state_i_s[3] = 64'h0011223344556677;
	state_i_s[4] = 64'h8899aabbccddeeff;
	#10;
end	

// Ronde
initial begin
	round_i_s    = 0;
	#10; 
end

endmodule : pc_tb
