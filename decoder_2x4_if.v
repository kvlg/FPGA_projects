module decoder_2x4_if (a,b);
input [1:0] a;
output reg [3:0] b;

function reg [3:0] cd_b;
input reg [1:0] a;

begin

  if      (a == 0) cd_b = 4'b1110;
  else if (a == 1) cd_b = 4'b1101;
  else if (a == 2) cd_b = 4'b1011;
  else if (a == 3) cd_b = 4'b0111;
  else             cd_b =  'bx   ;

end
endfunction

assign b = cd_b(a); 

endmodule
