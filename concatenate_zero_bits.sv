module concatenate_zero_bits (flash,lfsr,data);
input bit flash;
integer i = 15;
input logic [15:0] lfsr;
output logic [4:0] data;

 always @(posedge flash)
 begin : lsfr_roll
 data <= {data[3:0],lfsr[i]};
 if (i > 0) i <= i - 1;
 else if (i == 0) i <= 15;
 end : lsfr_roll

endmodule : concatenate_zero_bits