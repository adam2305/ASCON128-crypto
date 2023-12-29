`timescale 1ns/1ps

import ascon_pack::*;

module compteur_double_init_tb ();

logic clock_s, reset_s, en_cpt_s, init_a_s, init_b_s;
logic [3:0] cpt_s;

compteur_double_init inst
(
	.clock_i (clock_s),
	.resetb_i(reset_s),
	.en_cpt_i(en_cpt_s),
	.init_a_i(init_a_s),
	.init_b_i(init_b_s),
	.cpt_o(cpt_s)
);

initial 
begin
	clock_s = 0;
	forever #5 clock_s = ~ clock_s ;
end

initial
begin
	reset_s = 1;
	#40;
	reset_s = 0;
end

initial
begin
	en_cpt_s = 1;
	init_a_s = 1;
	init_b_s = 0;
	#10;
	init_a_s = 0;
end

endmodule : compteur_double_init_tb