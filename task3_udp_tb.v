 `define TD 5 
 `timescale 1ns/1ns 
 module task3_udp_tb (); 
    reg [3:0] x;
    reg en;
    wire f; 

    integer i; 
    my_primitive mp (y, x[3], x[2], x[1], x[0]);

bufif1 (f,y,en);

initial begin
$display("My fuction with UserDefPrmtv");
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

 primitive my_primitive (y, a, b, c, d); 
    output y; 
    input a, b, c, d; 
    table 
         
     0 0 0 0 : 0; 
     0 0 0 1 : 1; 
     0 0 1 0 : 0; 
     0 0 1 1 : 0; 
     0 1 0 0 : 1; 
     0 1 0 1 : 1; 
     0 1 1 0 : 1; 
     0 1 1 1 : 1; 
     1 0 0 0 : 1; 
     1 0 0 1 : 0; 
     1 0 1 0 : 1; 
     1 0 1 1 : 0; 
     1 1 0 0 : 1; 
     1 1 0 1 : 0; 
     1 1 1 0 : 1; 
     1 1 1 1 : 0; 
      
    endtable 
  endprimitive
