module choice_1of5_pierce (x,y);
input [4:0] x;
output y;

  assign y = ~( x[4] |  x[3] |  x[2] |  x[1] | ~(x[0] | x[0])) |
             ~( x[4] |  x[3] | ~(x[2] | x[2]) |  x[1] |  x[0]) | 
             ~(~(x[4] | x[4]) |  x[3] |  x[2] |  x[1] |  x[0]) | 
             ~( x[4] |  x[3] |  x[2] | ~(x[1] | x[1]) |  x[0]) | 
             ~( x[4] | ~(x[3] | x[3]) |  x[2] |  x[1] |  x[0]) ;
endmodule
