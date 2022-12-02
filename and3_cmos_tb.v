`define TD 5 
`timescale 1ns/1ns 

module and3_cmos_tb (); 
reg [2:0] x; 
wire y;
wire [2:0] w; 
integer i; 
supply1 vcc;
supply0 gnd;
  
 nmos  q1 (w[0],gnd,x[0]); nmos  q2 (w[1],w[0],x[1]); // nmos in series
 nmos  q3 (w[2],w[1],x[2]);
  
 pmos  q4 (w[2],vcc,x[0]); pmos q5 (w[2],vcc,x[1]);   // pmos parallel
 pmos  q6 (w[2],vcc,x[2]);
 
 nmos q7 (y,gnd,w[2]); pmos q8 (y,vcc,w[2]); // output inverter cmos-based

initial begin
$display("AND3 function cmos");
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
