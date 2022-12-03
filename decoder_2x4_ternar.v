module decoder_2x4_ternar (input [1:0] a, output [3:0] b);

  assign b = (a == 0) ? 4'b1110  :
             (a == 1) ? 4'b1101  :
             (a == 2) ? 4'b1011  :
             (a == 3) ? 4'b0111  :
                        4'bxxxx  ; 

endmodule
