
`timescale 1 ns /1 ps

import ascon_pack::*;

module permutation_v1_tb();

type_state val_i_s, val_o_s;
logic select_s, clock_s, reset_s, Enable_s;
logic[3:0] round_s;

permutation_v1 permutation_inst
(
   .val_i(val_i_s),
   .val_o(val_o_s),
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
    val_i_s[0] = 64'h80400c0600000000;
    val_i_s[1] = 64'h0001020304050607;
    val_i_s[2] = 64'h08090a0b0c0d0e0f;
    val_i_s[3] = 64'h0011223344556677;
    val_i_s[4] = 64'h8899aabbccddeeff;
end

endmodule : permutation_v1_tb














	

