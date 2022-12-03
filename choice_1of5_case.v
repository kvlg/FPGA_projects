module choice_1of5_case (x,y);
input [4:0] x;
output reg y;

 always @(x)
  begin 
  case (x) 1 : y = 1;
           2 : y = 1;
           4 : y = 1;
           8 : y = 1;
          16 : y = 1;
  default      y = 0;
  endcase
  end
endmodule
