/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : dff64.sv
*  Description : package definition
*  Author      : POTIN OLivier 
*  Source      : https://ecampus.emse.fr/mod/resource/view.php?id=24137
*  Modified_by : SEBTI Adam 
*/


`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'dff64'
*
*  input:d_i : information sur 64 bits en entrée de la bascule.
*  input:clock_i : Signal de clock.
*  input:resetb_i : Signal de reset.
*  input:enable_i : Signal qui côntrole l'allumage de la bascule D.
*  output:q_o : Information en sortie de la bascule D.
*
*  Ce composant décrit un registre de 64 bits qui utilise des bascules D 
*  il sera utilisé pour sauvegarder les cipher.
*/
module dff_64 (
    input  logic       clock_i, 
    input  logic       resetb_i, 
    input  logic       enable_i,
    input  logic[63:0] d_i,
    
    output logic[63:0] q_o );

always_ff @( posedge clock_i or negedge resetb_i )
begin :seq_0

    if ( resetb_i == 0)
        q_o <= 0;

    else if (enable_i == 1)
        q_o <= d_i ;

end : seq_0

endmodule : dff_64