`include "decoder_2x4_fullsys.v"
`include "decoder_2x4_pierce.v"
`include "decoder_2x4_sheffer.v"
`include "decoder_2x4_zhegalkin.v"
`include "decoder_2x4_ternar.v"
`include "decoder_2x4_case.v"
`include "decoder_2x4_if.v"

module decoder_2x4_tb (input [1:0] a, output [3:0] b);
 parameter description = "CASE";
 generate
 case (description) 
"FULLSYS" : begin // Transistor-based
decoder_2x4_fullsys mutut ( .a( a ), .b( b ) );
 end 
"PEARCE" : begin // Pearce {OR-NOT}
decoder_2x4_pierce mutut ( .a( a ), .b( b ) );
 end
"SHEFFER" : begin // Scheffer {AND-NOT}
decoder_2x4_sheffer mutut ( .a( a ), .b( b ) );
 end 
"ZHEGALKIN" : begin // Zhegalkin {XOR, AND, 1}
decoder_2x4_zhegalkin mutut ( .a( a ), .b( b ) );
 end
"TERNAR" : begin // Ternary operator
decoder_2x4_ternar mutut ( .a( a ), .b( b ) );
 end
"CASE" : begin // case
decoder_2x4_case mutut ( .a( a ), .b( b ) );
 end
"IF" : begin // if
decoder_2x4_if mutut ( .a( a ), .b( b ) );
 end
default    begin   // ????? {?, ???, ??}
 end 
endcase 
endgenerate
endmodule
