/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : pl_tb.sv
*  Description : testbench
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'pl_tb'
* 
*  Testbench du composant pl
*
*/
module pl_tb();
	
	type_state pl_i_s;
	type_state pl_o_s;

	pl pl_DUT(	
    	.pl_i(pl_i_s),
    	.pl_o(pl_o_s) );

initial begin
	pl_i_s[0] = 64'h80400c0600000000;
	pl_i_s[1] = 64'h0001020304050607;
	pl_i_s[2] = 64'h08090a0b0c0d0eff;
	pl_i_s[3] = 64'h0011223344556677;
	pl_i_s[4] = 64'h8899aabbccddeeff;
	#10;
end

endmodule : pl_tb

