`define TD 5 
`timescale 1ns/1ns 

module task3_bip_Pirs_tb (); 

integer i;
reg [3:0] x;
wire [3:0] nx;
wire [8:0] dterm; 
reg en;
wire y, f; 

not (nx[0], x[0]); not (nx[1], x[1]); not (nx[2], x[2]); not (nx[3], x[3]);
nor dt1 (dterm[0], x[3], x[2], x[1],nx[0]); nor dt2 (dterm[1], x[3],nx[2], x[1], x[0]);
nor dt3 (dterm[2], x[3],nx[2], x[1],nx[0]); nor dt4 (dterm[3], x[3],nx[2],nx[1], x[0]);
nor dt5 (dterm[4], x[3],nx[2],nx[1],nx[0]); nor dt6 (dterm[5],nx[3], x[2], x[1], x[0]);
nor dt7 (dterm[6],nx[3], x[2],nx[1], x[0]); nor dt8 (dterm[7],nx[3],nx[2], x[1], x[0]);
nor dt9 (dterm[8],nx[3],nx[2],nx[1], x[0]);

or    (y,dterm[0],dterm[1],dterm[2],dterm[3],dterm[4],dterm[5],dterm[6],dterm[7],dterm[8]);
bufif1 (f,y,en);

initial begin
$display("My fuction Pirs-based");
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
