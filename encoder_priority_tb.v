`timescale 1ns/1ns 
module encoder_priority_tb (); 
localparam size = 3; 
reg [2**size-1:0] a_in = 2**(2**size)-1; 
wire [size-1:0] b_out;
encoder_priority #(size) p1 (a_in,b_out);
initial 
repeat (2**(2**size)-1) 
#(50) a_in = a_in - 1; 
endmodule

module encoder_priority (a,b); 
parameter SIZE = 2; 
input [2**SIZE-1:0] a; 
output [SIZE-1:0] b;

function integer prcd; 
input [2**SIZE-1:0] in; 
integer i;
begin : fun 
 prcd = 'b0; 
 for (i = 2**SIZE-1; i >= 0; i = i - 1) 
 if (in[i] == 1'b0) 
 begin 
 prcd = 2**SIZE - i - 1; 
 disable fun; 
 end
end 
endfunction

assign b = prcd(a); 
endmodule
