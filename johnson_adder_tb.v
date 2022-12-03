`timescale 1ns/1ns 
module johnson_adder_tb ();
 reg clock = 0;
 wire [5:0] j;
 wire [3:0] br;
 johnson_counter jc (clock,j,br);
 initial repeat (100) #5 clock = ~clock;
endmodule

module rsff  (q,clock,r,s);
 output reg q = 0;
 input clock, r, s;

always @(posedge clock)
  if (r && s) q <= 1'bx;
  else if (s) q <= 1'b1;
  else if (r) q <= 1'b0;
endmodule

module johnson_counter (clock,q,br);
 input clock;
 output [5:0] q;
 output reg [3:0] br; 
 reg [5:0] r, s;

 always @*
 case (q)
 'b000000 : {r,s} = 'b?????0000001;
 'b000001 : {r,s} = 'b????0000001?;
 'b000011 : {r,s} = 'b???0000001??;
 'b000111 : {r,s} = 'b??0000001???;
 'b001111 : {r,s} = 'b?0000001????;
 'b011111 : {r,s} = 'b0000001?????;
 'b111111 : {r,s} = 'b000001?????0;
 'b111110 : {r,s} = 'b00001?????00;
 'b111100 : {r,s} = 'b0001?????000;
 'b111000 : {r,s} = 'b001?????0000;
 'b110000 : {r,s} = 'b01?????00000;
 'b100000 : {r,s} = 'b1?????000000;
 endcase

 genvar i;
 generate
 for (i = 0; i < 6; i = i + 1)
 rsff rsffi (q[i],clock,r[i],s[i]);
 endgenerate

always @*
case (q)
 'b000000 : br = 'b0000;
 'b000001 : br = 'b0001;
 'b000011 : br = 'b0010;
 'b000111 : br = 'b0011;
 'b001111 : br = 'b0100;
 'b011111 : br = 'b0101;
 'b111111 : br = 'b0110;
 'b111110 : br = 'b0111;
 'b111100 : br = 'b1000;
 'b111000 : br = 'b1001;
 'b110000 : br = 'b1010;
 'b100000 : br = 'b1011;
endcase

endmodule
