`include "encoder_4x2_fullsys.v"
`include "encoder_4x2_pierce.v"
`include "encoder_4x2_sheffer.v"
`include "encoder_4x2_zhegalkin.v"
`include "encoder_4x2_ternar.v"
`include "encoder_4x2_case.v"
`include "encoder_4x2_if.v"
module encoder_4x2_tb (input [3:0] a, output [1:0] b);
 parameter description = "TERNAR";
 generate
 case (description) 
"FULLSYS" : begin // Transistor-based
 encoder_4x2_fullsys mutut ( .a( a ), .b( b ) );
 end 
"PEARCE" : begin // Pearce {OR-NOT}
 encoder_4x2_pierce mutut ( .a( a ), .b( b ) );
 end 
"SHEFFER" : begin // Scheffer {AND-NOT}
 encoder_4x2_sheffer mutut ( .a( a ), .b( b ) );  
 end 
"ZHEGALKIN" : begin // Zhegalkin {XOR, AND, 1}
 encoder_4x2_zhegalkin mutut ( .a( a ), .b( b ) ); 
 end
"TERNAR" : begin // Ternary operator
 encoder_4x2_ternar mutut ( .a( a ), .b( b ) ); 
 end
"CASE" : begin // case
 encoder_4x2_case mutut ( .a( a ), .b( b ) ); 
 end
"IF" : begin // if
 encoder_4x2_if mutut ( .a( a ), .b( b ) ); 
 end
default    begin   // ????? {?, ???, ??}
 end 
endcase 
endgenerate
endmodule
