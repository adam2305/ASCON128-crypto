/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : pc.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'pc'
* 
*  input:state_i  : Etat courant de 320 bits en entrée.
*  input:round_i  : Ronde i sur 4 bits.
*  output:state_o : Etat courant en sortie.
* 
*  Ce composant ajoute une constante, choisie selon la valeur round_i, 
*  à l'état courant state_i. 
*
*/
module pc(
	input  type_state state_i,
	input  logic[3:0] round_i,

	output type_state state_o );

	assign state_o[0] = state_i[0];
	assign state_o[1] = state_i[1];
	assign state_o[2] = state_i[2] ^ {56'b0, round_constant[round_i]};
	assign state_o[3] = state_i[3];
	assign state_o[4] = state_i[4];

endmodule : pc

