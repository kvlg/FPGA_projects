module decoder_2x4_zhegalkin (input [1:0] a, output [3:0] b);
 supply1 vcc;
 wire [3:0] nb;

 always @(a);
  begin

//   assign b[3] = a[1] & a[0] ^ vcc;
//   assign b[2] = a[1] & a[0] ^ vcc  ^ a[1];
//   assign b[1] = a[1] & a[0] ^ vcc  ^ a[0];
//   assign b[0] = a[1] & a[0] ^ a[1] ^ a[0]; 

   and (nb[3], a[0], a[1]);
   xor (b[3], nb[3], vcc),
       (b[2],  a[1], b[3]),
       (b[1],  a[0], b[3]),
       (b[0],  a[1], a[0], nb[3]); 

 end
endmodule
