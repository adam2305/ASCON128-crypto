
`timescale 1 ns /1 ps

import ascon_pack::*;

module permutation_v2_tb();

type_state val_i_s, val_o_s;
logic[63:0] data_s;
logic[127:0] key_s;
logic select_s, clock_s, reset_s, Enable_s, xor_data_s, xor_key_s;
logic[3:0] round_s;

permutation_v2 permutation_inst
(
   .val_i(val_i_s),
   .val_o(val_o_s),
   .data_i(data_s),
   .key_i(key_s),
   .xor_data_i(xor_data_s),
   .xor_key_i(xor_key_s),
   .select_i(select_s),
   .clock_i(clock_s),
   .reset_i(reset_s),
   .enable_i(Enable_s),
   .round_i(round_s)
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
end

//enable_s
initial 
begin 
    Enable_s = 1;
    #1200
    Enable_s = 0;
end

// val_o
initial 
begin
    val_i_s[0] = 64'h1fc9a149abfd3af5;
    val_i_s[1] = 64'hdbf2eef89f61a7c5;
    val_i_s[2] = 64'h7d53f3d9dd22530a;
    val_i_s[3] = 64'h6654c154e6e248f1;
    val_i_s[4] = 64'h169557420d2a6714;
end

// xor
initial
begin
    data_s = 64'h3230323380000000;
    key_s = 128'h000102030405060708090A0B0C0D0E0F;
    xor_key_s = 1;
    xor_data_s = 0;
    #100
    xor_key_s = 0;
    xor_data_s = 0;
end

endmodule : permutation_v2_tb














	

