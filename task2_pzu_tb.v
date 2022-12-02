`define TD 5 
`timescale 1ns/1ns 

module task2_pzu_tb (); 

integer i;
supply0 gnd;
supply1 vcc;
wire[3:0] bw; // wires in the output bufif
reg [3:0] x;
wire [3:0] nx; 
wire [15:0] m;  
reg en;
wire ny, y, f; 

// ------ OUTPUT BUFFER w/ 3rd condition ------ //
                            pmos q1 (bw[0],vcc,bw[3]);
    pmos q5 (bw[2],vcc,y);  pmos q2 (f,bw[0],bw[2]);
    nmos q6 (bw[2],gnd,y);  nmos q3 (f,bw[1],bw[2]);
                            nmos q4 (bw[1],gnd,en);

    pmos q7 (bw[3],vcc,en);
    nmos q8 (bw[3],gnd,en); 
// -------------------------------------------- //

// -------------------------------------------- AND  -------------------------------------------- //
pmos (nx[0],vcc,x[0]);  pmos (nx[1],vcc,x[1]);  pmos (nx[2],vcc,x[2]);  pmos (nx[3],vcc,x[3]);
nmos (nx[0],gnd,x[0]);  nmos (nx[1],gnd,x[1]);  nmos (nx[2],gnd,x[2]);  nmos (nx[3],gnd,x[3]);
/* x[0], nx[0] */       /* x[1], nx[1] */       /* x[2], nx[2] */       /* x[3], nx[3] */
nmos (m[0], gnd, x[3]); nmos (m[0], gnd, x[2]); nmos (m[0], gnd, x[1]); nmos (m[0], gnd, x[0]); rnmos (m[0], vcc,vcc); // -> m0
nmos (m[1], gnd, x[3]); nmos (m[1], gnd, x[2]); nmos (m[1], gnd, x[1]); nmos (m[1], gnd,nx[0]); rnmos (m[1], vcc,vcc); // -> m1
nmos (m[2], gnd, x[3]); nmos (m[2], gnd, x[2]); nmos (m[2], gnd,nx[1]); nmos (m[2], gnd, x[0]); rnmos (m[2], vcc,vcc); // -> m2
nmos (m[3], gnd, x[3]); nmos (m[3], gnd, x[2]); nmos (m[3], gnd,nx[1]); nmos (m[3], gnd,nx[0]); rnmos (m[3], vcc,vcc); // -> m3
nmos (m[4], gnd, x[3]); nmos (m[4], gnd,nx[2]); nmos (m[4], gnd, x[1]); nmos (m[4], gnd, x[0]); rnmos (m[4], vcc,vcc); // -> m4
nmos (m[5], gnd, x[3]); nmos (m[5], gnd,nx[2]); nmos (m[5], gnd, x[1]); nmos (m[5], gnd,nx[0]); rnmos (m[5], vcc,vcc); // -> m5
nmos (m[6], gnd, x[3]); nmos (m[6], gnd,nx[2]); nmos (m[6], gnd,nx[1]); nmos (m[6], gnd, x[0]); rnmos (m[6], vcc,vcc); // -> m6
nmos (m[7], gnd, x[3]); nmos (m[7], gnd,nx[2]); nmos (m[7], gnd,nx[1]); nmos (m[7], gnd,nx[0]); rnmos (m[7], vcc,vcc); // -> m7
nmos (m[8], gnd,nx[3]); nmos (m[8], gnd, x[2]); nmos (m[8], gnd, x[1]); nmos (m[8], gnd, x[0]); rnmos (m[8], vcc,vcc); // -> m8
nmos (m[9], gnd,nx[3]); nmos (m[9], gnd, x[2]); nmos (m[9], gnd, x[1]); nmos (m[9], gnd,nx[0]); rnmos (m[9], vcc,vcc); // -> m9
nmos (m[10],gnd,nx[3]); nmos (m[10],gnd, x[2]); nmos (m[10],gnd,nx[1]); nmos (m[10],gnd, x[0]); rnmos (m[10],vcc,vcc); // -> m10
nmos (m[11],gnd,nx[3]); nmos (m[11],gnd, x[2]); nmos (m[11],gnd,nx[1]); nmos (m[11],gnd,nx[0]); rnmos (m[11],vcc,vcc); // -> m11
nmos (m[12],gnd,nx[3]); nmos (m[12],gnd,nx[2]); nmos (m[12],gnd, x[1]); nmos (m[12],gnd, x[0]); rnmos (m[12],vcc,vcc); // -> m12
nmos (m[13],gnd,nx[3]); nmos (m[13],gnd,nx[2]); nmos (m[13],gnd, x[1]); nmos (m[13],gnd,nx[0]); rnmos (m[13],vcc,vcc); // -> m13
nmos (m[14],gnd,nx[3]); nmos (m[14],gnd,nx[2]); nmos (m[14],gnd,nx[1]); nmos (m[14],gnd, x[0]); rnmos (m[14],vcc,vcc); // -> m14
nmos (m[15],gnd,nx[3]); nmos (m[15],gnd,nx[2]); nmos (m[15],gnd,nx[1]); nmos (m[15],gnd,nx[0]); rnmos (m[15],vcc,vcc); // -> m15
// --------------------------------------------------------------------------------------------------------------------//

// ------ OR ------ //
 rnmos (ny,vcc,vcc);
//nmos (ny,gnd,m[0]);
  nmos (ny,gnd,m[1]);
//nmos (ny,gnd,m[2]);
//nmos (ny,gnd,m[3]);
  nmos (ny,gnd,m[4]);
  nmos (ny,gnd,m[5]);
  nmos (ny,gnd,m[6]);
  nmos (ny,gnd,m[7]);
  nmos (ny,gnd,m[8]);
//nmos (ny,gnd,m[9]);
  nmos (ny,gnd,m[10]);
//nmos (ny,gnd,m[11]);
  nmos (ny,gnd,m[12]);
//nmos (ny,gnd,m[13]);
  nmos (ny,gnd,m[14]);
//nmos (ny,gnd,m[15]);
  pmos (y,vcc,ny);
  nmos (y,gnd,ny);
// ------------------------------- // 

initial begin
$display("My fuction PZU-based");
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
