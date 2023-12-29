/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : mux.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'mux'
*
*  input:permutation_i  : Etat sur 320 bit en entrée nouveau.
*  input:permutation_c  : Etat sur 320 qui vient d'être calculé.
*  input:init_i         : Signal de côntrole de la sortie du multiplexeur.
*  output:permutation_o : Etat en sortie du multiplexeur.
*
*  Composant qui décrit un multiplexeur permettant de choisit entre une nouvelle valeur 
*  de l'état courant du système ou boucler en récuperant l'état qui vient d'être calculé.
*/
module mux(
    input type_state permutation_i, 
    input type_state permutation_c,
    input logic init_i,

    output type_state permutation_o );

    assign permutation_o = (init_i) ? permutation_c : permutation_i;

endmodule : mux
