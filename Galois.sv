module Galois (Gflash,lfsr);
input bit Gflash;
output logic [15:0] lfsr = 16'b0000000000000001;

always @(posedge Gflash) begin: fireupdatrand
lfsr = {lfsr[ 0],
        lfsr[15],
        lfsr[14] ^ lfsr[0],
        lfsr[13],
        lfsr[12] ^ lfsr[0],
        lfsr[11] ^ lfsr[0],
        lfsr[10:2],
        lfsr[ 1] ^ lfsr[0] };
end : fireupdatrand

endmodule : Galois
