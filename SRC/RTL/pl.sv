/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : pl.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'pl'
*
*  input:pl_i  : Etat courant de 320 bits en entrée.
*  output:pl_o : Etat courant de 320 bits en sortie.
*
*  Applique une diffusion linéaire à chaque ligne 
*  composant l'état courant.
*/
module pl(
	input  type_state pl_i,

	output type_state pl_o );

	assign pl_o[0] = pl_i[0] ^ {pl_i[0][18:0], pl_i[0][63:19]} ^ {pl_i[0][27:0], pl_i[0][63:28]};
	assign pl_o[1] = pl_i[1] ^ {pl_i[1][60:0], pl_i[1][63:61]} ^ {pl_i[1][38:0], pl_i[1][63:39]};
	assign pl_o[2] = pl_i[2] ^ {pl_i[2][0]   , pl_i[2][63:1] } ^ {pl_i[2][5:0] , pl_i[2][63:6] };
	assign pl_o[3] = pl_i[3] ^ {pl_i[3][9:0] , pl_i[3][63:10]} ^ {pl_i[3][16:0], pl_i[3][63:17]};
	assign pl_o[4] = pl_i[4] ^ {pl_i[4][6:0] , pl_i[4][63:7] } ^ {pl_i[4][40:0], pl_i[4][63:41]};

endmodule : pl
