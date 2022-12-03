module choice_1of5_ternar (x,y);
input [4:0] x;
output y;

  assign y = (x == 1 ) ? 1'b1  :
             (x == 2 ) ? 1'b1  :
             (x == 4 ) ? 1'b1  :
             (x == 8 ) ? 1'b1  :
             (x == 16) ? 1'b1  :
                         1'b0  ; 
endmodule
