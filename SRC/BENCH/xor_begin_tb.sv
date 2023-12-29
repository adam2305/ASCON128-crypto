`timescale 1 ns /1 ps

import ascon_pack::*;

module xor_begin_tb();

type_state state_i_s;
type_state state_o_s;
logic[63:0] xor_data_s;
logic[255:0] key_s;
logic ena_xor_data_s;
logic mode_ext_s;

xor_begin DUT
(
        .state_i(state_i_s),
	.state_o(state_o_s),
	.xor_data_i(xor_data_s),
	.key_i(key_s),
	.ena_xor_data_i(ena_xor_data_s),
	.mode_ext_i(mode_ext_s)
);


initial
begin

    state_i_s[0] = 64'h1b1354db77e0dbb4;
    state_i_s[1] = 64'h6f140401cfa0873c;
    state_i_s[2] = 64'hd7e8abaf45f2885a;
    state_i_s[3] = 64'hc0c4757ca2646459;
    state_i_s[4] = 64'hf44a7ed98e1d9c83;

    key_s = {128'b0,128'h000102030405060708090A0B0C0D0E0F};
    
    ena_xor_data_s = 1;
    mode_ext_s = 1;

    #20;

end

endmodule : xor_begin_tb
