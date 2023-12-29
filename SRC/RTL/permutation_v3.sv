/*******************************************************************
*  Copyright (c) 2023 Ecole des Mines de Saint-Étienne
*
*  This software is released under the MIT License.
*  See the LICENSE file for details.
********************************************************************/

/*
*  Filename    : permutation_v3.sv
*  Description : package definition
*  Author      : SEBTI Adam
*/

`timescale 1 ns /1 ps
import ascon_pack::*;


/*
*
*  Module 'permutation_v2'
*
*  input:val_i            : Etat sur 320 bits en entrée.
*  input:select_i         : Signal coix sortie mux.
*  input:clock_i          : Signal de clock.
*  input:reset            : Signal de reset.
*  input:enable_i         : Signal On/Off de la bascule D.
*  input:round_i          : Ronde i.
*  input:key_i            : Clé de chiffrement.
*  input:xor_data_i_begin : Opération XOR debut avec données associées.
*  input:xor_key_i_begin  : Opération XOR dbut avec clé de chiffrement.
*  input:xor_data_i_end   : Opération XOR fin avec données associées.
*  input:xor_key_i_end    : Opération XOR fin avec clé de chiffrement.
*  input:enable_i         : Signal On/Off porte XOR.
*  output:val_o           : Etat en sortie.
*
*  Composant décrivant toute la partie permutation du process ASCON128
*  avec les 3 permutations p et l'opération xor begin.
*/
module permutation_v3(
    input  type_state   val_i,
    input  logic[63:0]  data_i,
    input  logic[127:0] key_i,
    input  logic        select_i, 
    input  logic        clock_i, 
    input  logic        reset_i, 
    input  logic        enable_i, 
    input  logic        xor_data_i_begin, 
    input  logic        xor_key_i_begin,
    input  logic        xor_key_i_end,
    input  logic        xor_ext_i_end,
    input  logic[3:0]   round_i,

    output type_state   val_o );

    type_state tmp1;
    type_state tmp2;
    type_state tmp3;
    type_state tmp4;

    mux mux_inst
    (
        .permutation_i(val_i),
        .permutation_s(val_o),
        .permutation_o(tmp1),
        .init_i(select_i)
    );

    xor_begin xor_begin_inst
    (
        .state_i(tmp1),
        .state_o(tmp2),
        .data_i(data_i),
        .key_i(key_i),
        .xor_data_i(xor_data_i_begin),
        .xor_key_i(xor_key_i_begin)
    );

    p p_inst
    (
        .p_i(tmp2),
        .round_i(round_i),
        .p_o(tmp3)
    );

    xor_end xor_end_inst
    (
    	.state_i(tmp3),
    	.state_o(tmp4),
    	.key_i(key_i),
    	.xor_key_i(xor_key_i_end),
    	.xor_ext_i(xor_ext_i_end)
    );

    dff dff_inst
    (
        .d_i(tmp4),
        .clock_i(clock_i),
        .resetb_i(reset_i),
        .enable_i(enable_i),
        .q_o(val_o)
    );


endmodule : permutation_v3
