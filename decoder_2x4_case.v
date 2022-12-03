module decoder_2x4_case (a,b);
input [1:0] a;
output reg [3:0] b;

 always @(a)
  begin 
  case (a) 0 : b = 14;
           1 : b = 13;
           2 : b = 11;
           3 : b =  7;
  default      b = 'bx;
  endcase
 end

endmodule
