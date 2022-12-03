`timescale 1ns/1ns 
module gray_substracter_tb ();
 reg clock = 0;
 wire [3:0] br, g;
 gray_counter gc (clock,g,br);
 initial repeat (100) #5 clock = ~clock;
endmodule

module jkff  (q,clock,j,k);
 output reg q = 0;
 input clock, j, k;

 always @(posedge clock)
  if (j && k) q <= ~q;
  else if (j) q <= 1'b1;
  else if (k) q <= 1'b0;
endmodule

module gray_counter (clock,q,br);
 input clock;
 output [3:0] q;
 output reg [3:0] br; 
 reg [3:0] j, k;

 always @*
 case (q)
 'b0000 : {j,k} = 'b1000????;
 'b0001 : {j,k} = 'b000????1;
 'b0011 : {j,k} = 'b00????10;
 'b0010 : {j,k} = 'b00?1??0?;
 'b0110 : {j,k} = 'b0??0?10?;
 'b0111 : {j,k} = 'b0?0??0?1;
 'b0101 : {j,k} = 'b001????0;
 'b0100 : {j,k} = 'b0?01?0??;
 'b1100 : {j,k} = 'b??0010??;
 'b1101 : {j,k} = 'b??0?00?1;
 'b1111 : {j,k} = 'b????0010;
 'b1110 : {j,k} = 'b???1000?;
 'b1010 : {j,k} = 'b?1?00?0?;
 'b1011 : {j,k} = 'b?0??0?01;
 'b1001 : {j,k} = 'b?01?0??0;
 'b1000 : {j,k} = 'b?0010???;
 endcase

 genvar i;
 generate
 for (i = 0; i < 4; i = i + 1)
 jkff jkffi (q[i],clock,j[i],k[i]);
 endgenerate

always @*
case (q)
 'b0000 : br = 'b0000;
 'b0001 : br = 'b0001;
 'b0011 : br = 'b0010;
 'b0010 : br = 'b0011;
 'b0110 : br = 'b0100;
 'b0111 : br = 'b0101;
 'b0101 : br = 'b0110;
 'b0100 : br = 'b0111;
 'b1100 : br = 'b1000;
 'b1101 : br = 'b1001;
 'b1111 : br = 'b1010;
 'b1110 : br = 'b1011;
 'b1010 : br = 'b1100;
 'b1011 : br = 'b1101;
 'b1001 : br = 'b1110;
 'b1000 : br = 'b1111;
endcase

endmodule
