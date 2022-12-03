module encoder_4x2_ternar (input [3:0] a, output [1:0] b);
 wire [3:0] na;

  assign na = (a == 1) ? 4'b1110  :
              (a == 2) ? 4'b1101  :
              (a == 4) ? 4'b1011  :
              (a == 8) ? 4'b0111  :
                          'bx     ; 

  assign b = (na == 14) ? 2'b11  :
             (na == 13) ? 2'b10  :
             (na == 11) ? 2'b01  :
             (na ==  7) ? 2'b00  :
                           'bx   ; 

endmodule