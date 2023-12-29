`timescale 1ns/1ps

import ascon_pack::*;

module fsm 
(
	// input de la FSM
	input logic      data_valid_i, 
	input logic      start_i, 
	input logic      clock_i, 
	input logic      resetb_i,
	input logic[3:0] round_i,
	input logic[1:0] bloc_i,
	//signaux non de contôlz
	output logic     cipher_valid_o, 
	output logic 	 end_o,
	//signaux de contôle du compteur de round
	output logic  	 en_cpt_round_o, 
	output logic 	 init_a_round_o, 
	output logic 	 init_b_round_o, 
	// siganux de contrôle compteur de blocs
	output logic 	 init_cpt_bloc_o, 
	output logic 	 en_cpt_bloc_o,
	//sigaux de contôle permutation
	output logic 	 enable_o,
	output logic 	 select_o,
		//contrôle xor 
	output logic 	 xor_data_i_begin_o, 
	output logic 	 xor_key_i_begin_o, 
	output logic 	 xor_key_i_end_o, 
	output logic 	 xor_ext_i_end_o, 
	output logic 	 en_cipher_o, 
	output logic 	 en_tag_o
);

typedef enum {	idle, 
				set_cpt, 
				conf_init, 
				init, 
				end_init, 
				wait_datavalid, 
				conf_data_associe, 
				data_associe, 
				end_data_associe, 
				conf_cipher, 
				cipher, 
				end_cipher, 
				wait_last_cipher, 
				conf_finalisation, 
				finalisation, 
				tag_finalisation, 
				end_finalisation} machine_state;

machine_state current_state;
machine_state next_state;
machine_state comeback_state;


always_ff @ ( posedge clock_i or negedge resetb_i )
begin : seq_0
if (resetb_i == 0)
// n o n b l o c k i n g a ssi gnme nt
current_state <= idle ;
else
current_state <= next_state ;
end : seq_0

always_comb
begin : comb0
	case(current_state)

		wait_datavalid : begin
			next_state = (data_valid_i) ? comeback_state : wait_datavalid; 
		end
		
		idle : begin
			next_state = (start_i) ? set_cpt : idle; 
		end
		
		set_cpt : begin
			next_state = conf_init; 
		end
		
		conf_init : begin
			next_state = init;
		end 

		init : begin
			next_state = (round_i == 10) ? end_init : init;
		end

		end_init : begin
			next_state     = wait_datavalid;
			comeback_state = conf_data_associe;
		end 

		conf_data_associe : begin
			next_state = data_associe;
		end

		data_associe : begin
			next_state = (round_i == 10) ? end_data_associe : data_associe;
		end

		end_data_associe : begin
			next_state     = wait_datavalid;
			comeback_state = conf_cipher;
		end

		conf_cipher : begin
			next_state = cipher;
		end

		cipher : begin
			next_state = (round_i == 10) ? end_cipher : cipher;
		end

		end_cipher : begin
			comeback_state = conf_cipher;
			next_state = (bloc_i == 3) ? wait_last_cipher : wait_datavalid;
		end

		wait_last_cipher : begin
			next_state = (data_valid_i) ? conf_finalisation : wait_last_cipher;
		end

		conf_finalisation : begin
			next_state = finalisation;
		end

		finalisation : begin
			next_state = (round_i == 10) ? tag_finalisation : finalisation;
		end

		tag_finalisation : begin
			next_state = end_finalisation;
		end

		end_finalisation : begin
			next_state = wait_datavalid;
		end

		default : begin 
			next_state = idle;
		end
	endcase

end : comb0


always_comb
begin : comb_1
	case (current_state)
	idle: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b0; 
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b0;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b0;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
	end 
	set_cpt: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b1;
		init_b_round_o     = 1'b0;
		select_o           = 1'b0;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b0;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
	end
	conf_init: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b0;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	init : begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	end_init : begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b0;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b1;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	wait_datavalid: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b1;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b0;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end
	conf_data_associe: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b1;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	data_associe: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	end_data_associe: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b0;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b1;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	conf_cipher:  begin 
		cipher_valid_o     = 1'b1;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b1;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b1;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b1; 
		en_cpt_bloc_o      = 1'b1;
		end 
	cipher: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b1;
		end 
	end_cipher: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	wait_last_cipher: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b1;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b0;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	conf_finalisation: begin 
		cipher_valid_o     = 1'b1;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b1;
		xor_key_i_begin_o  = 1'b1;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b1;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	finalisation: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	tag_finalisation: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b1;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b1;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b1;
		enable_o           = 1'b1;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 

	end_finalisation: begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b1;
		en_cpt_round_o     = 1'b0;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b1;
		xor_data_i_begin_o = 1'b0;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b0;
		enable_o           = 1'b0;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	default : begin 
		cipher_valid_o     = 1'b0;
		end_o              = 1'b0;
		en_cpt_round_o     = 1'b0;
		init_a_round_o     = 1'b0;
		init_b_round_o     = 1'b0;
		select_o           = 1'b0;
		xor_data_i_begin_o = 1'b1;
		xor_key_i_begin_o  = 1'b0;
		xor_key_i_end_o    = 1'b0;
		xor_ext_i_end_o    = 1'b0;
		en_cipher_o        = 1'b0;
		en_tag_o           = 1'b1;
		enable_o           = 1'b0;
		init_cpt_bloc_o    = 1'b0; 
		en_cpt_bloc_o      = 1'b0;
		end 
	endcase ; // case (current_state)
end : comb_1

endmodule : fsm