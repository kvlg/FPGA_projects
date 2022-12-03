module encoder_4x2_zhegalkin (input [3:0] a, output [1:0] b);
 supply1 vcc;
 supply0 gnd;
 wire [3:0] na;
 wire [2:0] cterm;

 always @(a);
  begin

//   assign b[1] = ~a[3] & ~a[2] & ~a[1] ^ ~a[3] & ~a[2] & ~a[0],
//          b[0] = ~a[3] & ~a[2] & ~a[1] ^ ~a[3] & ~a[1] & ~a[0]; 

   xor (na[3],a[3],vcc), (na[2],a[2],vcc),
       (na[1],a[1],vcc), (na[0],a[0],vcc);
   and (cterm[0],na[3],na[2],na[1]),
       (cterm[1],na[3],na[2],na[0]),
       (cterm[2],na[3],na[1],na[0]);
   xor (    b[1],cterm[0],cterm[1]),
       (    b[0],cterm[0],cterm[2]);
   
  end

endmodule