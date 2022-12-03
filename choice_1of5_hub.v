`include "choice_1of5_mdnf.v"
`include "choice_1of5_mknf.v"
`include "choice_1of5_pierce.v"
`include "choice_1of5_sheffer.v"
`include "choice_1of5_zhegalkin.v"
`include "choice_1of5_ternar.v"
`include "choice_1of5_case.v"
`include "choice_1of5_if.v"

module choice_1of5_hub (input [4:0] x, output y);
 parameter description = "MDNF";
 generate
 case (description) 
"MDNF" : begin // MDNF-based
choice_1of5_mdnf mutut ( .x( x ), .y( y ) );
 end 
"MKNF" : begin // MKNF-based
choice_1of5_mknf mutut ( .x( x ), .y( y ) );
 end
"PEARCE" : begin // Pearce {OR-NOT}
choice_1of5_pierce mutut ( .x( x ), .y( y ) );
 end
"SHEFFER" : begin // Scheffer {AND-NOT}
choice_1of5_sheffer mutut ( .x( x ), .y( y ) );
 end 
"ZHEGALKIN" : begin // Zhegalkin {XOR, AND, 1}
choice_1of5_zhegalkin mutut ( .x( x ), .y( y ) );
 end
"TERNAR" : begin // Ternary operator
choice_1of5_ternar mutut ( .x( x ), .y( y ) );
 end
"CASE" : begin // case
choice_1of5_case mutut ( .x( x ), .y( y ) );
 end
"IF" : begin // if
choice_1of5_if mutut ( .x( x ), .y( y ) );
 end
default    begin   // ????? {?, ???, ??}
 end 
endcase 
endgenerate
endmodule
