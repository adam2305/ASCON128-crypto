/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : sps_tb.sv
*  Description : Testbench
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'ps_tb'
*
*  Testbench du module ps
*/
module ps_tb();

	type_state ps_i_s;
	type_state ps_o_s;

	ps ps_DUT(
		.ps_i(ps_i_s),
		.ps_o(ps_o_s) );

initial begin
	ps_i_s[0] = 64'h80400c0600000000;
	ps_i_s[1] = 64'h0001020304050607;
	ps_i_s[2] = 64'h08090a0b0c0d0eff;
	ps_i_s[3] = 64'h0011223344556677;
	ps_i_s[4] = 64'h8899aabbccddeeff;
	#10;
end

endmodule : ps_tb
