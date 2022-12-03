`include "encoder_4x2_tb.v"
`timescale 1ns/1ns
module encoder_4x2_top (); 
reg [3:0] a; 
wire [1:0] b; 
integer i;
encoder_4x2_tb #("IF") mut ( .a( a ), .b( b ) );

initial
 $monitor(
 "t = %3.0f ns, a = %b, b = %b",
 $time, a, b);

 initial
 begin
 for (i = 0; i < 4; i = i + 1)
 begin
 a = 2**i; #50;
 end
 end 
endmodule
