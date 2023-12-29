/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : permutation_v2.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;

/*
*
*  Module 'permutation_v2'
*
*  input:val_i      : Etat sur 320 bits en entrée.
*  input:select_i   : Signal coix sortie mux.
*  input:clock_i    : Signal de clock.
*  input:reset      : Signal de reset.
*  input:enable_i   : Signal On/Off de la bascule D.
*  input:round_i    : Ronde i.
*  input:key_i      : Clé de chiffrement.
*  input:xor_data_i : Opération XOR avec données associées.
*  input:xor_key_i  : Opération XOR avec clé de chiffrement.
*  input:enable_i   : Signal On/Off porte XOR.
*  output:val_o     : Etat en sortie.
*
*  Composant décrivant toute la partie permutation du process ASCON128
*  avec les 3 permutations p et l'opération xor begin.
*/
module permutation_v2(
    input  type_state   val_i,
    input  logic[63:0]  data_i,
    input  logic[127:0] key_i,
    input  logic        select_i, 
    input  logic        clock_i, 
    input  logic        reset_i, 
    input  logic        enable_i, 
    input  logic        xor_data_i, 
    input  logic        xor_key_i,
    input  logic[3:0]   round_i,

    output type_state   val_o );

    type_state output_mux;
    type_state output_xor_begin;
    type_state output_p;

    mux mux_inst(
        .permutation_i (val_i),
        .permutation_s (val_o),
        .permutation_o (output_mux),
        .init_i        (select_i));

    xor_begin xor_begin_inst(
        .state_i    (output_mux),
        .state_o    (output_xor_begin),
        .data_i     (data_i),
        .key_i      (key_i),
        .xor_data_i (xor_data_i),
        .xor_key_i  (xor_key_i));

    p p_inst(
        .p_i   (output_xor_begin),
        .round_i (round_i),
        .p_o  (output_p));

    dff dff_inst(
        .d_i      (output_p),
        .clock_i  (clock_i),
        .resetb_i (reset_i),
        .enable_i (enable_i),
        .q_o      (val_o));


endmodule : permutation_v2
