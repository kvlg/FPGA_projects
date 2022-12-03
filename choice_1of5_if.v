module choice_1of5_if (x,y);
input [4:0] x;
output reg y;

always @(x)
begin
  if      (x == 1 ) y = 1'b1;
  else if (x == 2 ) y = 1'b1;
  else if (x == 4 ) y = 1'b1;
  else if (x == 8 ) y = 1'b1;
  else if (x == 16) y = 1'b1;
  else              y = 1'b0;
end
endmodule
