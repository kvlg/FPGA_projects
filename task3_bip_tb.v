`define TD 5 
`timescale 1ns/1ns 

module task3_bip_tb (); 

integer i;
reg [3:0] x;
wire [6:0] cterm; 
reg en;
wire y, f; 

and ct1 (cterm[0],x[3],x[2],x[1],x[0]);
and ct2 (cterm[1],x[3],x[2],     x[0]);
and ct3 (cterm[2],x[3],x[2]          );
and ct4 (cterm[3],x[3],     x[1],x[0]);
and ct5 (cterm[4],     x[2],x[1],x[0]);
and ct6 (cterm[5],     x[2],     x[0]);
and ct7 (cterm[6],          x[1],x[0]);

xor    (y,cterm[0],cterm[1],cterm[2],cterm[3],x[3],cterm[4],cterm[5],x[2],cterm[6],x[0]);
bufif1 (f,y,en);

initial begin
$display("My fuction Zhegalkin-based");
$display("--------------------------");
$display("En   i  x3  x2  x1  x0  y");

  for (i = 0; i < 32; i = i + 1) 
    begin 
      if (i[3:0] == 0)
      begin
      $display("--------------------------");
      end
      x = i; en = i[4]; #`TD; 
      $write("%b   %2d  %b   %b   %b   %b   %b\n", en, i[3:0], x[3], x[2], x[1], x[0], f);
    end 
  $display("--------------------------"); 
  end
endmodule
