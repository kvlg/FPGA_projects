`define TD 5 
`timescale 1ns/1ns 

module or3_tranif_tb (); 
reg [2:0] x; 
wire y;
wire [2:0] w; 
integer i; 
supply1 vcc;
supply0 gnd;
  
 tranif0  k6 (w[1],vcc,x[0]); tranif0  k5 (w[2],w[1],x[1]); // tranif0 in series
 tranif0  k4 (w[0],w[2],x[2]);
  
 tranif1  k1 (w[0],gnd,x[0]); tranif1 k2 (w[0],gnd,x[1]);   // tranif1 parallel
 tranif1  k3 (w[0],gnd,x[2]);
 
 tranif1 k7 (y,gnd,w); tranif0 k8 (y,vcc,w); // output inverter

initial begin
$display("OR3 func tranif");
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
