`define TD 5 
`timescale 1ns/1ns 

module and3_pmos_tb (); 
reg [2:0] x; 
wire y;
wire [1:0] w;
wire [2:0] nx;
integer i; 
supply1 vcc;
supply0 gnd;
  
 rpmos rq1 (y,gnd,gnd);
 
 pmos qin1 (nx[0],vcc,x[0]); rpmos rqin1 (nx[0],gnd,gnd);  // input
 pmos qin2 (nx[1],vcc,x[1]); rpmos rqin2 (nx[1],gnd,gnd);  // inverters
 pmos qin3 (nx[2],vcc,x[2]); rpmos rqin3 (nx[2],gnd,gnd);

 pmos  q1 (w[0],vcc,nx[0]); pmos  q2 (w[1],w[0],nx[1]);
 pmos  q3 (y,w[1],nx[2]); 
 
initial begin
$display("AND3 function pmos");
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
