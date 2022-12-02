`define TD 5 
`timescale 1ns/1ns 

module and3_nmos_tb (); 
reg [2:0] x; 
wire y;
wire [2:0] w;
integer i; 
supply1 vcc;
supply0 gnd;
  
 rnmos rq1 (w[2],vcc,vcc);
 
 nmos  q1 (w[0],gnd,x[0]); nmos  q2 (w[1],w[0],x[1]);
 nmos  q3 (w[2],w[1],x[2]); 

 nmos  q4 (y,gnd,w[2]); rnmos rq2 (y,vcc,vcc); 
 
initial begin
$display("AND3 function nmos");
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