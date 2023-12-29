`timescale 1ns/1ps

import ascon_pack::*;

module compteur_bloc_tb ();

logic clock_s;
logic resetb_s;
logic enable_s;
logic init_s;
logic [1:0] cpt_s;

compteur_bloc inst
(
	.clock_i(clock_s),
	.resetb_i(resetb_s),
	.enable_i(enable_s),
	.init_i(init_s),
	.cpt_o(cpt_s)
);

initial 
begin
	clock_s = 1;
	forever #5 clock_s = ~ clock_s ;
end

initial
begin
	resetb_s = 0;
	#10
	resetb_s = 1;
	#30 
	resetb_s = 0;
end

initial
begin
	enable_s = 1;
	init_s = 1;
end

endmodule : compteur_bloc_tb
