 `timescale 1ns/1ns 
module decoder_bin_dec (); 
reg [3:0] a_in; 
wire [9:0] b_out;
integer i = 0; 
 
decoder_bd mut (a_in, b_out); 
 
initial begin
for (i = 0; i < 15; i = i + 1)
  begin
    a_in = i;
    $monitor("a = %b, b = %b", a_in, b_out);
    #(50);
  end
end      

endmodule

module decoder_bd (a,b);
input [3:0] a;
output reg [9:0] b;

assign  b = 65536 - 2 ** a - 1;

endmodule
