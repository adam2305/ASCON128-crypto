`timescale 1 ns /1 ps

import ascon_pack::*;

module permutation_v4_tb();

type_state val_i_s, val_o_s;
logic[63:0] data_s;
logic[63:0] cipher_s;
logic[127:0] key_s;
logic[127:0] tag_s;
logic[127:0] nonce_s;
logic select_s, clock_s, reset_s, Enable_s, xor_data_begin_s, xor_key_begin_s, xor_key_end_s, xor_ext_end_s;
logic enable_tag_s, enable_cipher_s;
logic[3:0] round_s;

permutation_v4 permutation_inst
(
   .val_i(val_i_s),
   .val_o(val_o_s),
   .cipher_o(cipher_s),
   .tag_o(tag_s),
   .data_i(data_s),
   .key_i(key_s),
   .nonce_i(nonce_s),
   .xor_data_i_begin(xor_data_begin_s),
   .xor_key_i_begin(xor_key_begin_s),
   .xor_key_i_end(xor_key_end_s),
   .xor_ext_i_end(xor_ext_end_s),
   .select_i(select_s),
   .clock_i(clock_s),
   .reset_i(reset_s),
   .enable_i(Enable_s),
   .round_i(round_s),
   .enable_cipher_i(enable_cipher_s),
   .enable_tag_i(enable_tag_s)
);


// Clock
initial
begin 
    clock_s = 0;
    forever #50 clock_s = ~clock_s;
end

// reset_s
initial
begin
    reset_s = 0;
    #25
    reset_s = 1;
end

initial
begin
    select_s = 0;
    #100;
    select_s = 1;
end


//round s
initial 
begin
    integer i;
    for( i=0; i<12; i++) 
	begin
	round_s = i;
	#100;
	end

    for( i=6; i<12; i++) 
    begin
    round_s = i;
    #100;
    end

    round_s=6;

end

//enable_s
initial 
begin 
    Enable_s = 1;
    #1900;
    Enable_s = 0;
end

//data
initial 
begin 
data_s = 64'h3230323380000000;
#1800
data_s = 64'h436F6E636576657A;
end

// val_o
initial 
begin
    key_s = 128'h000102030405060708090A0B0C0D0E0F;
    nonce_s = 128'h00112233445566778899AABBCCDDEEFF;

    val_i_s[0] = 64'h80400C0600000000;;
    val_i_s[1] = key_s[127:64];
    val_i_s[2] = key_s[63:0];
    val_i_s[3] = nonce_s[127:64];
    val_i_s[4] = nonce_s[63:0];
end

// xor_begin
initial
begin
    xor_key_begin_s = 0;
    xor_data_begin_s = 0;
    #1200;
    xor_key_begin_s = 0;
    xor_data_begin_s = 1;
    #100;
    xor_key_begin_s = 0;
    xor_data_begin_s = 0;
    #500
    xor_key_begin_s = 0;
    xor_data_begin_s = 1;
    #100
    xor_key_begin_s = 0;
    xor_data_begin_s = 0;


end

// xor_end
initial
begin
	xor_key_end_s = 0;
	xor_ext_end_s = 0;
	#1100;
	xor_key_end_s = 1;
	xor_ext_end_s = 0;
    #100
    xor_key_end_s = 0;
    xor_ext_end_s = 0;
    #500
    xor_key_end_s = 0;
    xor_ext_end_s = 1;
    #100
    xor_key_end_s = 0;
    xor_ext_end_s = 0;
end

//cipher
initial 
begin
    enable_cipher_s = 0;
    #1800;
    enable_cipher_s = 1;
    #100;
    enable_cipher_s = 0;


end

endmodule : permutation_v4_tb