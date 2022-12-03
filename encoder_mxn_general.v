`timescale 1ns/1ns 
module encoder_mxn_general (); 
localparam S = 4; 
reg [2**S - 1:0] a_in; 
wire [S-1:0] b_out;
integer i = 0; 
 
encoder_mxn #(S) mut (a_in, b_out); 
 
initial begin
for (i = 0; i < 2**S; i = i + 1)
begin a_in = 2 ** (2 ** S) - 2 ** i - 1; #(50);  end
end      

endmodule

module encoder_mxn (a,b);
parameter SIZE = 2;
input [2**SIZE - 1:0] a;
output [SIZE - 1:0] b;
integer na, nb;

 function integer flog2; 
 input integer number; 
 integer tmp; 
 if ((number == 0) || (number == 1)) 
   flog2 = 0; 
 else 
   begin 
     tmp = 1; 
     while (2 ** tmp <= number)
       tmp = tmp + 1; 
     flog2 = tmp - 1; 
   end 
 endfunction 

 function integer cd; 
 input integer na;
 integer shift; 
 begin 
 shift = flog2(na); 
 cd = (na == 2 ** shift) ? shift : 'bx; 
 end 
 endfunction 

assign na = 2 ** (2 ** SIZE) - a - 1,
       nb = cd(na),
        b = 2 ** SIZE - nb - 1;

endmodule
