`timescale 1 ns /1 ps

import ascon_pack::*;

module permutation_v5
(
    input  logic[63:0]  data_i,
    input  logic[127:0] key_i,
    input  logic[127:0] nonce_i,
    input  logic        select_i, 
    input  logic        clock_i, 
    input  logic        reset_i, 
    input  logic        enable_i, 
    input  logic        xor_data_i_begin, 
    input  logic        xor_key_i_begin,
    input  logic        xor_key_i_end,
    input  logic        xor_ext_i_end,
    input  logic        enable_tag_i, 
    input  logic        enable_cipher_i,
    input  logic[3:0]   round_i,
    output logic[63:0]  cipher_o,
    output logic[127:0] tag_o
);


type_state val_i;
type_state val_o;
type_state tmp1;
type_state tmp2;
type_state tmp3;
type_state tmp4;

assign val_i[0] = 64'h80400C0600000000;
assign val_i[1] = key_i[127:64];
assign val_i[2] = key_i[63:0];
assign val_i[3] = nonce_i[127:64];
assign val_i[4] = nonce_i[63:0];


mux mux_inst
(
    .permutation_i  (val_i),
    .permutation_s  (val_o),
    .permutation_o  (tmp1),
    .init_i         (select_i)
);

xor_begin xor_begin_inst
(
    .state_i        (tmp1),
    .state_o        (tmp2),
    .data_i         (data_i),
    .key_i          (key_i),
    .xor_data_i     (xor_data_i_begin),
    .xor_key_i      (xor_key_i_begin)
);

dff_64 dff_cipher
(
    .d_i            (tmp2[0]),
    .clock_i        (clock_i),
    .resetb_i       (reset_i),
    .enable_i       (enable_cipher_i),
    .q_o            (cipher_o)
);

p p_inst
(
    .p_i          (tmp2),
    .round_i        (round_i),
    .p_o         (tmp3)
);

xor_end xor_end_inst
(
	.state_i        (tmp3),
	.state_o        (tmp4),
	.key_i          (key_i),
	.xor_key_i      (xor_key_i_end),
	.xor_ext_i      (xor_ext_i_end)
);

dff_128 dff_tag
(
    .d_i            ({tmp4[3],tmp4[4]}),
    .clock_i        (clock_i),
    .resetb_i       (reset_i),
    .enable_i       (enable_tag_i),
    .q_o            (tag_o)
);

dff dff_inst
(
    .d_i            (tmp4),
    .clock_i        (clock_i),
    .resetb_i       (reset_i),
    .enable_i       (enable_i),
    .q_o            (val_o)
);

endmodule : permutation_v5
