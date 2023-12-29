
`timescale 1 ns /1 ps

module p_tb ();
import ascon_pack::*;

type_state pin_s;
type_state pout_s;
logic[3:0] round_s;

p p_inst
(
	.pin_i(pin_s),
	.pout_o(pout_s),
	.round_i(round_s)
);

initial 
begin
	round_s = 0;
	pin_s[0] = 64'h80400c0600000000;
	pin_s[1] = 64'h0001020304050607;
	pin_s[2] = 64'h08090a0b0c0d0e0f;
	pin_s[3] = 64'h0011223344556677;
	pin_s[4] = 64'h8899aabbccddeeff;
	#10;
end 
endmodule : p_tb
