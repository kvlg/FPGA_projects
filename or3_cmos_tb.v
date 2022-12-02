`define TD 5 
`timescale 1ns/1ns 

module or3_cmos_tb (); 
reg [2:0] x; 
wire y;
wire [2:0] w; 
integer i; 
supply1 vcc;
supply0 gnd;
  
 pmos  q6 (w[1],vcc,x[0]); pmos  q5 (w[2],w[1],x[1]); // ??????????????? ???????????
 pmos  q4 (w[0],w[2],x[2]);                           // p-????????? ???
  
 nmos  q1 (w[0],gnd,x[0]); nmos q2 (w[0],gnd,x[1]);   // ??????????? ???????????
 nmos  q3 (w[0],gnd,x[2]);                            // n-????????? ???
 
 nmos q7 (y,gnd,w); pmos q8 (y,vcc,w); // ???????? ????-????????

initial begin
$display("OR3 function cmos");
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
