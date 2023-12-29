/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : p.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns/1 ps
import ascon_pack::*;

/*
*
*  Module 'p'
*
*  input:p_i     : Etat courant de 320 bits en entrée.
*  input:round_i : Ronde sur 4 bits.
*  output:p_o    : Etat courant de 320 bits en sortie.
*
*  Ce composant regroupe pc, ps et pl pour faire transformer un état
*  couant en une seule fois.
*
*/
module p(
	input  type_state p_i,
	input  logic[3:0] round_i,

	output type_state p_o );

	// Etats intermédiaires
	type_state output_pc;
	type_state output_ps;
	type_state output_pl;

	pc pc_inst(
		.state_i    (p_i),
		.round_i (round_i),
		.state_o    (output_pc));

	ps ps_inst(
		.ps_i    (output_pc),
		.ps_o    (output_ps));

	pl pl_inst(
		.pl_i    (output_ps),
		.pl_o    (output_pl));

	assign p_o = output_pl;

endmodule : p



