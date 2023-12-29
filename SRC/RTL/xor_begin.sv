/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : xor_begin.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Moridule 'xor_begin'
*  
*  input:state_i   : Etat courant sur 320 bits en entrée.
*  input:key_i     : Clé de chiffrement sur 128 bits.
*  input:xor_key_i : Signal activation xor avec clé.
*  input:xor_ext_i : Signal activation xor avec {0,...,0,1}.
*  input:data_i    : Données associées.
*  output:state_o  : Etat courant en sortie.
*
*  Composant permettant d'effectuer les opération de type XOR au debut
*  d'une permutation .
*/
module xor_begin(
	input  type_state   state_i,
	input  logic[63:0]  data_i,
	input  logic[127:0] key_i,
	input  logic        xor_data_i,
	input  logic        xor_key_i,

	output type_state   state_o );

always @* begin
	case ({xor_data_i,xor_key_i})

		2'b00: begin state_o = state_i; end

		2'b01: begin state_o[0] = state_i[0];
		       		 state_o[3] = state_i[3];
		       		 state_o[2] = state_i[2] ^ key_i[63:0];
		       		 state_o[1] = state_i[1] ^ key_i[127:64];
		       		 state_o[4] = state_i[4]; end

		2'b10: begin state_o[0] = state_i[0] ^ data_i;
				     state_o[1] = state_i[1];
				     state_o[2] = state_i[2];
				     state_o[3] = state_i[3];
				     state_o[4] = state_i[4]; end

		2'b11: begin state_o[0] = state_i[0] ^ data_i;
				     state_o[3] = state_i[3];
		     	     state_o[2] = state_i[2] ^ key_i[63:0];
				     state_o[1] = state_i[1] ^ key_i[127:64];
				     state_o[4] = state_i[4]; end

		default: begin state_o = state_i; end

    endcase
end

endmodule : xor_begin

