`include "decoder_2x4_tb.v"
`timescale 1ns/1ns

module decoder_2x4_top (); 
reg [1:0] a; 
wire [3:0] b; 
realtime t;
decoder_2x4_tb #("IF") mut ( .a( a ), .b( b ) );

initial
 begin
  a = 0;
  forever
   begin
    t = $time;
    $strobe(
    "t = %3.0f ns, a = %b, b = %b", t, a, b);
    #50;
    a = a + 1;
   end
 end
initial
 begin #200;
  $stop;
 end
endmodule



