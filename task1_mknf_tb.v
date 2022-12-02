`define TD 5 
`timescale 1ns/1ns 

module task1_mknf_tb (); 
reg [3:0] x; 
wire nx0, nx1, nx3;
reg en;
wire y, f;
wire[2:0] w;
wire[3:0] bw; // wires in the output bufif
integer i; 
supply1 vcc;
supply0 gnd;

// ------ OUTPUT BUFFER w/ 3rd condition ------ //
                             pmos q1b (bw[0],vcc,bw[3]);
    pmos q5b (bw[2],vcc,y);  pmos q2b (f,bw[0],bw[2]);
    nmos q6b (bw[2],gnd,y);  nmos q3b (f,bw[1],bw[2]);
                             nmos q4b (bw[1],gnd,en);

    pmos q7b (bw[3],vcc,en);
    nmos q8b (bw[3],gnd,en); 
// -------------------------------------------- //
  
rnmos rq1 (w[0],vcc,vcc); rnmos rq2 (w[1],vcc,vcc); 
rnmos rq3 (w[2],vcc,vcc); rnmos rq4 (y,vcc,vcc); 

 nmos  q1 (w[0],gnd,x[3]); nmos q2 (w[0],gnd,x[2]); nmos  q3 (w[0],gnd,x[0]); // 1st disterm
 nmos  q4 (w[1],gnd,x[2]); nmos q5 (w[1],gnd,nx1);  nmos  q6 (w[1],gnd,nx0);  // 2nd disterm
 nmos  q7 (w[2],gnd,nx3);  nmos q8 (w[2],gnd,nx0);                            // 3rd disterm

 nmos  q9 (y,gnd,w[0]);    nmos q10 (y,gnd,w[1]);   nmos  q11 (y,gnd,w[2]);   // 1 & 2 & 3
 
 nmos iq0 (nx0,gnd,x[0]);  pmos iq1 (nx0,vcc,x[0]); // input 
 nmos iq2 (nx1,gnd,x[1]);  pmos iq3 (nx1,vcc,x[1]); // cmos-based
 nmos iq4 (nx3,gnd,x[3]);  pmos iq5 (nx3,vcc,x[3]); // inverters

initial begin
$display("My fuction MKNF-based");
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
