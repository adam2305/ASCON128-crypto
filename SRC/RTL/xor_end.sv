/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : xor_end.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Moridule 'xor_end'
*  
*  input:state_i   : Etat courant sur 320 bits en entrée.
*  input:key_i     : Clé de chiffrement sur 128 bits.
*  input:xor_key_i : Signal activation xor avec clé.
*  input:xor_ext_i : Signal activation xor avec {0,...,0,1}.
*  output:state_o  : Etat courant en sortie .
*
*  Composant permettant d'effectuer les opération de type XOR à la fin 
*  d'une permutation donnée.
*/
module xor_end(
	input  type_state   state_i,
	input  logic[127:0] key_i,
	input  logic        xor_key_i,
	input  logic        xor_ext_i,

	output type_state   state_o );

always @* begin
	case ({xor_key_i,xor_ext_i})

		2'b00: begin state_o = state_i; end

		2'b01: begin state_o[0] = state_i[0];
		       		 state_o[3] = state_i[3];
		       		 state_o[2] = state_i[2];
		       		 state_o[1] = state_i[1];
		       		 state_o[4] = state_i[4] ^ {63'b0,1'b1}; end

		2'b10: begin state_o[0] = state_i[0];
					 state_o[1] = state_i[1];
					 state_o[2] = state_i[2];
					 state_o[3] = state_i[3] ^ key_i[127:64];
					 state_o[4] = state_i[4] ^ key_i[63:0]; end

		2'b11: begin state_o = state_i; end

		default: begin state_o = state_i; end

	endcase
end

endmodule : xor_end