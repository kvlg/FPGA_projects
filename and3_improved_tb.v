`define TD 5 
`timescale 1ns/1ns 

module and3_improved_tb (); 
reg [2:0] x; 
wire y;
wire [2:0] nx;
integer i; 
supply1 vcc;
supply0 gnd;
  
 rnmos rq1 (y,vcc,vcc);
  
 pmos pqin1 (nx[0],vcc,x[0]); nmos nqin1 (nx[0],gnd,x[0]);  // input cmos
 pmos pqin2 (nx[1],vcc,x[1]); nmos nqin2 (nx[1],gnd,x[1]);  // inverters
 pmos pqin3 (nx[2],vcc,x[2]); nmos nqin3 (nx[2],gnd,x[2]);

 nmos  q1 (y,gnd,nx[0]); nmos  q2 (y,gnd,nx[1]);
 nmos  q3 (y,gnd,nx[2]); 

initial begin
$display("AND3 func improved");
$display("-----------------");
$display("i  x2  x1  x0  y");
$display("-----------------");
  for (i = 0; i < 8; i = i + 1) 
    begin 
      x = i; #`TD; 
      $write("%1d  %b   %b   %b   %b\n", i, x[2], x[1], x[0], y);
    end 
  $display("-----------------"); 
  end
endmodule
