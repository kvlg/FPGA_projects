module decoder_2x4_pierce (input [1:0] a, output [3:0] b);

 wire [1:0] na;
 wire [3:0] nb;

   nor (na[1], a[1], a[1]),
       (na[0], a[0], a[0]),
       (nb[3], na[1], na[0]),     (b[3], nb[3], nb[3]),
       (nb[2], na[1],  a[0]),     (b[2], nb[2], nb[2]),
       (nb[1],  a[1], na[0]),     (b[1], nb[1], nb[1]),
       (nb[0],  a[1],  a[0]),     (b[0], nb[0], nb[0]);

endmodule
