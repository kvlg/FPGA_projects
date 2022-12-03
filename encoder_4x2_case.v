module encoder_4x2_case (input [3:0] a, output reg [1:0] b);
reg [3:0] na;

always @(a)
 begin 
  case (a)  4'b0001 : na = 14;
            4'b0010 : na = 13;
            4'b0100 : na = 11;
            4'b1000 : na = 7 ;
            default : na = 'bx ;
  endcase
 end

always @(na)
 begin 
  case (na) 4'b1110 : b = 2'b11;
            4'b1101 : b = 2'b10;
            4'b1011 : b = 2'b01;
            4'b0111 : b = 2'b00;
            default : b =  'bx ;
  endcase
 end

endmodule
