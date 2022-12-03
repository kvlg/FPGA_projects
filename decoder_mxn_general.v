 `timescale 1ns/1ns 
module decoder_mxn_general (); 
localparam S = 2; 
reg [S-1:0] a_in; 
wire [2**S - 1:0] b_out;
integer i = 0; 
 
decoder_mxn #(S) mut (a_in, b_out); 
 
initial begin
for (i = 0; i < 2**S; i = i + 1)
begin a_in = i; #(50);  end
end      

endmodule

module decoder_mxn (a,b);
parameter SIZE = 2;
input [SIZE - 1:0] a;
output [2**SIZE - 1:0] b;

assign b = 2 ** (2 ** SIZE) - 2 ** a - 1;

endmodule
