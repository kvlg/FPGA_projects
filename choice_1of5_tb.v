`include "choice_1of5_hub.v"
`timescale 1ns/1ns

module choice_1of5_tb (); 
reg [4:0] x; 
wire y; 
choice_1of5_hub #(.description("IF")) 
             mut ( .x( x ), .y( y ) );

initial
 begin : testbench
  integer i;
  reg [18*8:1] str;
  str = {19{"-"}};
    $display("%s", str);
    $display("%s", "| i  |   x   | y |");
    $display("%s", str);
  for (i = 0; i < 32; i = i + 1) begin
    x = i;
    $strobe("| %2d | %05b | %b |", i, x, y);
    #25;
  end
 $display("%s", str);
 end
endmodule
