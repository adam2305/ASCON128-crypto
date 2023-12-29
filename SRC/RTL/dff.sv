/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : dff.sv
*  Description : package definition
*  Author      : POTIN OLivier 
*  Source      : https://ecampus.emse.fr/mod/resource/view.php?id=24137
*  Modified_by : SEBTI Adam 
*/

`timescale 1 ns /1 ps
import ascon_pack::*; 

/*
*
*  Module 'dff'
*
*  input:d_i : information sur 320 bits en entrée de la bascule.
*  input:clock_i : Signal de clock.
*  input:resetb_i : Signal de reset.
*  input:enable_i : Signal qui côntrole l'allumage de la bascule D.
*  output:q_o : Information en sortie de la bascule D.
*
*  Ce composant décrit un registre de 320 bits qui utilise des bascules D.
*/
module dff(	
    input  type_state d_i,
    input  logic      clock_i , 
    input  logic      resetb_i , 
    input  logic      enable_i,
    
    output type_state q_o );

always_ff @ ( posedge clock_i or negedge resetb_i )
begin : seq_0

    if ( resetb_i==0 && enable_i==1) 
	q_o <= 0; 

    else if ( enable_i==1) 
	q_o <= d_i;

end : seq_0

endmodule : dff
