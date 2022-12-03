module encoder_4x2_if (input [3:0] a, output reg [1:0] b);

function reg [1:0] cd_b;
input reg [3:0] a;
reg [3:0] na;
begin
  begin
    if      (a == 4'b0001) na = 4'b1110;
    else if (a == 4'b0010) na = 4'b1101;
    else if (a == 4'b0100) na = 4'b1011;
    else if (a == 4'b1000) na = 4'b0111;
    else                   na =  'bx   ;
  end
  
  begin 
    if      (na == 4'b1110) cd_b = 2'b11;
    else if (na == 4'b1101) cd_b = 2'b10;
    else if (na == 4'b1011) cd_b = 2'b01;
    else if (na == 4'b0111) cd_b = 2'b00;
    else                    cd_b =  'bx ;
  end
end
endfunction

assign b = cd_b(a); 

endmodule
