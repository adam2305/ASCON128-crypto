

`timescale 1ns/1ps

module top_level(
	input logic[63:0] data_i,
	input logic[127:0] key_i, 
	input logic [127:0] nonce_i,
	input logic start_i, 
	input logic data_valid_i, 
	input logic clock_i, 
	input logic resetb_i,
	output logic end_o, cipher_valid_o,
	output logic[63:0] cipher_o,
	output logic[127:0] tag_o
);

logic en_cpt_round_o_s;
logic init_a_round_o_s;
logic init_b_round_o_s;
logic init_cpt_bloc_o_s;
logic en_cpt_bloc_o_s;
logic enable_o_s;
logic select_o_s;
logic xor_data_i_begin_o_s;
logic xor_key_i_begin_o_s;
logic xor_key_i_end_o_s;
logic xor_ext_i_end_o_s;
logic en_cipher_o_s;
logic en_tag_o_s;
logic[3:0] round_s;
logic[1:0] bloc_s;

fsm fsm_DUT
(
	.data_valid_i      (data_valid_i),
	.start_i           (start_i),
	.clock_i		   (clock_i),
	.resetb_i		   (resetb_i),
	.round_i           (round_s),
	.bloc_i            (bloc_s),
	.cipher_valid_o    (cipher_valid_o),
	.end_o             (end_o),
	.en_cpt_round_o    (en_cpt_round_o_s),
	.init_a_round_o    (init_a_round_o_s),
	.init_b_round_o    (init_b_round_o_s),
	.init_cpt_bloc_o   (init_cpt_bloc_o_s),
	.en_cpt_bloc_o     (en_cpt_bloc_o_s),
	.enable_o          (enable_o_s),
	.select_o          (select_o_s),
	.xor_data_i_begin_o(xor_data_i_begin_o_s),
	.xor_key_i_begin_o (xor_key_i_begin_o_s),
	.xor_key_i_end_o   (xor_key_i_end_o_s),
	.xor_ext_i_end_o   (xor_ext_i_end_o_s),
	.en_cipher_o       (en_cipher_o_s),
	.en_tag_o          (en_tag_o_s)

);

permutation_v5 permutation_DUT
(
	.data_i(data_i),
	.key_i(key_i),
	.nonce_i(nonce_i),
	.select_i(select_o_s),
	.clock_i(clock_i),
	.reset_i(resetb_i),
	.enable_i(enable_o_s),
	.xor_data_i_begin(xor_data_i_begin_o_s),
	.xor_key_i_begin(xor_key_i_begin_o_s),
	.xor_key_i_end(xor_key_i_end_o_s),
	.xor_ext_i_end(xor_ext_i_end_o_s),
	.enable_tag_i(en_tag_o_s),
	.enable_cipher_i(en_cipher_o_s),
	.round_i(round_s),
	.cipher_o(cipher_o),
	.tag_o(tag_o)
);

compteur_double_init compteur_round_DUT
(
	.clock_i (clock_i),
	.resetb_i(resetb_i),
	.en_cpt_i(en_cpt_round_o_s),
	.init_a_i(init_a_round_o_s),
	.init_b_i(init_b_round_o_s),
	.cpt_o(round_s)
);

compteur_bloc compteur_bloc_DUT
(
	.clock_i (clock_i),
	.resetb_i(resetb_i),
	.enable_i(en_cpt_bloc_o_s),
	.init_i  (init_cpt_bloc_o_s),
	.cpt_o(bloc_s)
);

endmodule : top_level