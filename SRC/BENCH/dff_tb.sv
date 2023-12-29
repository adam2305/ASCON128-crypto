
`timescale 1 ns /1 ps

module dff_tb ();
import ascon_pack::*;

logic clock_s , resetb_s , enable_s;
type_state d_s, q_s;

dff DUT (
. d_i ( d_s ) ,
. resetb_i ( resetb_s ) ,
. clock_i ( clock_s ) ,
. q_o ( q_s ),
. enable_i (enable_s)
);

initial
begin
clock_s = 0;
forever #5 clock_s = ~ clock_s ;
end

initial
begin
resetb_s = 0;
enable_s = 1;
d_s = 0;
#50;
resetb_s = 1;
#25;
d_s = 1;
#50;
d_s = 0;
#50;
end
endmodule : dff_tb
