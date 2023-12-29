/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : ps.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
* 
*  Module 'ps'
*
*  input:ps_i  : Etat courant de 320 bits en entrée.
*  output:ps_o : Etat courant en sortie.
*
*  Substitution de l'etat courant en utlisant 64 composants 'sbox'
*  chacun agissant sur une colonne de 5 bits.
*/
module ps(
	input  type_state ps_i,

	output type_state ps_o );

	genvar i;
	
	generate
	    for (i=0; i<64; i++)
			sbox sbox_inst(
				.sbox_i({ps_i[0][i],
						 ps_i[1][i],
						 ps_i[2][i],
						 ps_i[3][i],
						 ps_i[4][i]}),

				.sbox_o({ps_o[0][i],
						 ps_o[1][i],
						 ps_o[2][i],
						 ps_o[3][i],
						 ps_o[4][i]}) );
	endgenerate

endmodule : ps
