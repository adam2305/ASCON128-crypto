/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : permutation_v1.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'permutation_v1'
*
*  input:val_i    : Etat sur 320 bits en entrée.
*  input:select_i : Signal coix sortie mux.
*  input:clock_i  : Signal de clock.
*  input:reset    : Signal de reset.
*  input:enable_i : Signal On/Off de la bascule D.
*  input:round_i  : ronde i.
*  output:val_o   : Etat en sortie.
*
*  Composant décrivant toute la partie permutation du process ASCON128
*  sans les portes XOR.
*/
module permutation_v1(
    input  type_state val_i,
    input  logic      select_i, 
    input  logic      clock_i, 
    input  logic      reset_i, 
    input  logic      enable_i,
    input  logic[3:0] round_i,

    output type_state val_o );

    //Etats intermédiaires
    type_state output_mux;
    type_state output_p;
    type_state output_dff;

    mux mux_inst(
        .permutation_i (val_i),
        .permutation_s (output_dff),
        .permutation_o (output_mux),
        .init_i        (select_i));

    p p_inst(
        .p_i   (output_mux),
        .round_i (round_i),
        .p_o  (output_p));

    dff dff_inst(
        .d_i      (output_p),
        .clock_i  (clock_i),
        .resetb_i (reset_i),
        .enable_i (enable_i),
        .q_o      (output_dff));

    assign val_o = output_dff;

endmodule : permutation_v1
